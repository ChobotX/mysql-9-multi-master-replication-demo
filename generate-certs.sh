openssl genpkey -algorithm RSA -out db/certs/ca-key.pem;
openssl req -new -x509 -key db/certs/ca-key.pem -out db/certs/ca-cert.pem -days 3650 -subj "/CN=MySQL-CA";
openssl req -newkey rsa:2048 -days 3650 -nodes -keyout db/certs/server-key.pem -out db/certs/server-req.pem -subj "/CN=db1";
openssl rsa -in db/certs/server-key.pem -out db/certs/server-key.pem;
openssl x509 -req -in db/certs/server-req.pem -days 3650 -CA db/certs/ca-cert.pem -CAkey db/certs/ca-key.pem -set_serial 01 -out db/certs/server-cert.pem;
