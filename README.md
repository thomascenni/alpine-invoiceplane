## Container for InvoicePlane running on Alpine Linux + S6.

This image is based on the awesome work of [Woahbase](https://github.com/woahbase), using [alpine-php](https://github.com/woahbase/alpine-php) as a starting point. PHP7 and NGINX included.

InvoicePlane is downloaded directly from the offical repository [InvoicePlane/InvoicePlane](https://github.com/InvoicePlane/InvoicePlane).

The image has been built at the time of v1.5.11 availability.

To run the container:

```
docker run --rm -it \
    --name docker_invoiceplane --hostname invoiceplane \
    -e DB_HOSTNAME=localhost \
    -e DB_USERNAME=invoiceplane \
    -e DB_PASSWORD=invoiceplane   \
    -e DB_DATABASE=invoiceplane \
    -e DB_PORT=3306 \
    -e IP_URL="http://localhost" \
    -p 80:80 \
    -v storage:/storage \
    -v config:/config \
    thomascenni/alpine-invoiceplane:v1.5.11
```

or use the [docker-compose.yml](docker-compose.yml) provided, which contains also a alpine-mysql instance.