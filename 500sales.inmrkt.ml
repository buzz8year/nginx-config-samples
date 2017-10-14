server {

    listen       80; # listen for IPv4
    #listen       [::]:80 ipv6only=on; # listen for IPv6

    server_name  500sales.inmrkt.ml;

    set $root_path  /var/www/500sales.inmrkt.ml/html;

    root         $root_path;

    #access_log   off;
    #error_log    /dev/null crit;
    charset      utf-8;
    client_max_body_size  100M;

    location / {
        root  $root_path/backend/web;
        try_files  $uri /backend/web/index.php$is_args$args;
    }

    location ~ \.php$ {

	include  /etc/nginx/fastcgi_params;       
       	
	# check the www.conf file to see if PHP-FPM is listening on a socket or port

	# fastcgi_pass  127.0.0.1:9000; # listen for a port
	fastcgi_split_path_info ^(.+\.php)(/.+)$;
        
	fastcgi_pass  unix:/var/run/php/php7.1-fpm.sock; # listen for a socket
        fastcgi_param  SCRIPT_FILENAME $document_root$fastcgi_script_name;
        
	try_files  $uri /backend/web$uri =404;

    }

    # avoid processing of calls to non-existing static files by Yii (uncomment if necessary)

    location ~ \.(css|js|jpg|jpeg|png|gif|bmp|ico|mov|swf|pdf|zip|rar)$ {
    #    access_log  off;
    #    log_not_found  off;
       try_files  $uri /backend/web$uri =404;
    }

    location ~* \.(htaccess|htpasswd|svn|git) {
        deny all;
    }

    location /front {
        
	alias  $root_path/frontend/web;

        # redirect to the page without a trailing slash (uncomment if necessary)
        
	location = /front/ {
           return  301 /front;
        }

        location ~ ^/front/(.+\.php)$ {
        
	    include  /etc/nginx/fastcgi_params;
            
	    # check the www.conf file to see if PHP-FPM is listening on a socket or port

	    # fastcgi_pass  127.0.0.1:9000; # listen for a port
	    fastcgi_split_path_info ^(.+\.php)(/.+)$;
            
	    fastcgi_pass  unix:/var/run/php/php7.1-fpm.sock; # listen for a socket
            fastcgi_param  SCRIPT_FILENAME $document_root/$1;

            try_files  $uri /frontend/web/$1$is_args$args;
        
	}

        # avoid processing of calls to non-existing static files by Yii (uncomment if necessary)
	
	location ~ ^/front/(.+\.(css|js|jpg|jpeg|png|gif|bmp|ico|mov|swf|pdf|zip|rar))$ {
		try_files  $uri /frontend/web/$1$is_args$args;
	}

        try_files  $uri /frontend/web/index.php$is_args$args;

    }

}
