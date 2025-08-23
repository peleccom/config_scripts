#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 <env_file>"
  exit 1
fi

# Чтение .env файла и экспорт значений, исключая комментарии и пустые строки
while IFS='=' read -r key value; do
  if [[ ! "$key" =~ ^# && -n "$key" ]]; then
    # Убираем лишние пробелы и обрабатываем значение как строку
    export "$key"="$value"
  fi
done < "$1"
