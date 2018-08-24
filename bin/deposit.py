#!/bin/env python3

from datetime import date
from datetime import datetime
from datetime import timedelta
from money.money import Money
from money.currency import Currency

class Deposit(object):
    def __init__(self, start_date: date, amount: Money, percent: float, duration_months: int):
        self._start_date = start_date
        self._start_amount = amount
        self._percent = percent
        self._duration_months = duration_months


    def calc(self):
        start_amount = self._start_amount
        for i in range(self._duration_months):
            amount = start_amount + (start_amount * self._percent * 31) // (365 * 100)
            print('{i}-я капитализация: {start_amount} + ({start_amount} * {percent} * 31 ) / (365 * 100) = {amount}'.format(
                **dict(
                    i=i+1,
                    start_amount=start_amount,
                    percent=self._percent,
                    amount=amount,
                )
            ))
            amount_final = amount - (amount - start_amount) * 13 // 100
            print('остаток вклада за вычетом подоходного налога {amount} - ({amount} - {start_amount}) * 13 / 100 = {amount_final}'.format(**
                dict(
                    amount=amount,
                    start_amount=start_amount,
                    amount_final=amount_final,
                    )
                ))
            start_amount = amount_final




def main():
    d = Deposit(date(2018, 6, 6), Money(12000, Currency.USD), 1,  3)
    d.calc()


if __name__ == '__main__':
    main()