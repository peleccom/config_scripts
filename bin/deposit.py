#!/usr/bin/env python3

import calendar
import enum
from datetime import date
from datetime import datetime
from datetime import timedelta
from pathlib import Path

import arrow

from dateutil.relativedelta import relativedelta

from ics import Calendar, Event

from money.money import Money
from money.currency import Currency

CRED = '\033[91m'
CEND = '\033[0m'


class EEventCategories(enum.Enum):
  open = 'open'
  close = 'close'
  add = 'add'

class Deposit(object):
    def __init__(
            self, start_date: date, amount: Money,
            percent: float, duration_months: int,
            last_month_amount: Money,
    ):
        self.start_date = start_date
        self.start_amount = amount
        self.percent = percent
        self.duration_months = duration_months
        self.last_month_amount = last_month_amount

    def calc(self):
        start_amount = self.start_amount
        for i in range(self.duration_months):
            if i == self.duration_months - 1:
                start_amount += self.last_month_amount
            deposit_date = self.start_date + relativedelta(months=i)

            days_in_month = calendar.monthrange(deposit_date.year, deposit_date.month)[1]
            days_in_year = 366 if calendar.isleap(deposit_date.year) else 365

            print('Calculation date {}:'.format(deposit_date))
            amount = (
                    start_amount +
                    (start_amount * self.percent * days_in_month) / (days_in_year * 100)
            )
            print(
                '{relative_month}-я капитализация: {start_amount} + ({start_amount} * {percent}'
                ' * {days_in_month} )'
                ' / ({days_in_year} * 100) = {amount}'.format(
                    **dict(
                        relative_month=i + 1,
                        start_amount=start_amount,
                        days_in_month=days_in_month,
                        percent=self.percent,
                        amount=amount,
                        days_in_year=days_in_year,
                    )
                ))
            amount_final = amount - (amount - start_amount) * 13 / 100
            print('остаток вклада за вычетом подоходного налога {amount} - ({amount} - '
                  '{start_amount}) * 13 / 100 = {amount_final}\n'.format(amount=amount,
                                                                         start_amount=start_amount,
                                                                         amount_final=amount_final,
                                                                         ))
            start_amount = amount_final

        self.amount_final = start_amount
        return_date = self.start_date + relativedelta(months=self.duration_months)
        self.end_date = return_date
        self.last_replenishment_date = self.end_date - relativedelta(months=1, days=1)

        print('end date {}'.format(self.end_date))
        while return_date.isoweekday() in [6, 7]:
            print('{} is weekend. Move forward..'.format(return_date))
            return_date += relativedelta(days=1)

        self.return_date = return_date
        self.money_available_date = return_date + relativedelta(days=2)


def main():
    percents_map = {
        3: 1,
        6: 1.4,
        12: 1.8
    }

    start_date = date(2018, 8, 24)

    d = start_date
    duration = 3
    last_month_amount = Money(12000, Currency.USD)

    deposits = []

    for i in range(24):
        print('Дата начала вклада {}. Длительность {} мес.'.format(d, duration))
        deposit = Deposit(d, Money(100, Currency.USD), percents_map[duration], duration,
                          last_month_amount)
        deposit.calc()
        print('День возврата {}'.format(deposit.return_date))
        print('День доступности средств {}'.format(deposit.money_available_date))

        d = deposit.return_date + relativedelta(days=3, months=1)
        print('#  Дата окончания вклада {}\n\n\n\n'.format(d))

        if (d - relativedelta(months=12)) > start_date:
            d = d - relativedelta(months=12)
            duration = 12
        elif (d - relativedelta(months=6)) > start_date:
            d = d - relativedelta(months=6)
            duration = 6
        elif (d - relativedelta(months=3)) > start_date:
            d = d - relativedelta(months=3)
            duration = 3

        deposits.append(deposit)
        last_month_amount = deposit.amount_final

    deposits.sort(key=lambda d: d.start_date)

    c = Calendar()

    print(CRED + '\n\nДаты открытия депозитов' + CEND)
    for deposit in deposits:
        print('Открытие {} срок {} мес. Закрытие {}'.format(deposit.start_date,
                                                            deposit.duration_months,
                                                            deposit.return_date))
        e = Event()
        e.name = '+ Вклад {} мес. Открытие'.format(deposit.duration_months)
        e.begin = arrow.get(datetime.combine(deposit.start_date, datetime.min.time()))
        e.make_all_day()
        e.categories = [EEventCategories.open.value]
        c.events.add(e)

        e = Event()
        e.name = '-> Вклад {} мес. Пополнение'.format(deposit.duration_months)
        e.begin = arrow.get(datetime.combine(deposit.last_replenishment_date,
                                             datetime.min.time()))
        e.make_all_day()
        e.categories = [EEventCategories.add.value]
        c.events.add(e)

        e = Event()
        e.name = 'x Вклад {} мес. Закрытие'.format(deposit.duration_months)
        e.begin = arrow.get(datetime.combine(deposit.return_date, datetime.min.time()))
        e.make_all_day()
        e.categories = [EEventCategories.close.value]
        c.events.add(e)

    calendar_filename = str(Path.home() / 'deposit.ics')
    with open(calendar_filename, 'w') as my_file:
        my_file.writelines(c)


if __name__ == '__main__':
    main()
