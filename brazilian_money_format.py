import locale


def main():
    locale.setlocale(locale.LC_ALL, "pt_BR.UTF-8")
    masked_amount = locale.currency(12345.67, grouping=True, symbol=False)
    print(f'R$ {masked_amount}')


if __name__ == '__main__':
    main()


