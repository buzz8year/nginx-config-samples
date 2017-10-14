server {
	listen 80;
	# listen [::]:80 ipv6only=on;

	root /var/www/oldfit.inmrkt.ml/html;
	index index.php index.html index.htm;

	server_name oldfit.inmrkt.ml www.oldfit.inmrkt.ml;

	location / {
		try_files $uri $uri/ =404;
		if (!-e $request_filename){
			rewrite ^/([^?]*) /index.php?_route_=$1 break;
		}
	}

	
	error_page 404 /404.html;
	error_page 500 502 503 504 /50x.html;

	location = /50x.html {
		root /var/www/oldfit.inmrkt.ml/html;
	}

	
	location ~ \.php$ {
	        try_files $uri =404;
	        fastcgi_split_path_info ^(.+\.php)(/.+)$;

	        fastcgi_pass unix:/var/run/php5-fpm.sock;
	        fastcgi_index index.php;
		fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        	include fastcgi_params;
	}
}
