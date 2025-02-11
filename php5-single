server {
	listen 80;

	root /var/www/rl.inmrkt.ml/html;
	access_log /var/www/rl.inmrkt.ml/logs/access.log;
	error_log /var/www/rl.inmrkt.ml/logs/error.log;
	index index.php index.html index.htm;

	server_name rl.inmrkt.ml www.rl.inmrkt.ml;

	location / {
		try_files $uri $uri/ =404;
	}

	
	error_page 404 /404.html;
	error_page 500 502 503 504 /50x.html;

	location = /50x.html {
		root /var/www/rl.inmrkt.ml/html;
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
