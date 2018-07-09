import ngrok
import sys
from urllib.parse import urlparse


def main():
    if len(sys.argv) < 2:
        print("Invalid argument, should be protocol")
        sys.exit(2)
    proto = sys.argv[1]

    tunnels = ngrok.client.get_tunnels()
    if not tunnels:
        sys.exit(1)

    for tunnel in tunnels:
        if tunnel.proto == proto:
            url = tunnel.public_url
            if proto == 'tcp':
                parse_result = urlparse(url)
                host, port = parse_result.netloc.split(':')
                print('{} -p {}'.format(host, port))
            else:
                print(url)
            sys.exit(0)


if __name__ == '__main__':
    main()
