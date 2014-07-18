
@load ./utils

module Phant;

export {
	const default_server = "data.sparkfun.com" &redef;

	type new: record {
		server:      string   &default=default_server;
		rate_limit:  count    &default=100;
		rate_period: interval &default=15mins;
		private_key: string;
		public_key:  string;
	};

	## Call this function to submit data to a Phant.io 
	## server.  This is an async function and must be
	## called within a when block.
	## 
	## p: An instance of a phant description record.
	##
	## data: A record that will be turned into key-value 
	##       pairs before being submitted to phant.
	##
	## Return: T on success.  F otherwise.
	global submit: function(p: Phant::new, data: any): bool;
}


function submit(p: Phant::new, data: any): bool
	{
	local data_string = convert_to_kv(data);
	local url = "http://" + p$server + "/input/" + p$public_key;
	# client_data is commented out to work around a bug in the ActiveHTTP module.
	# The data is submitted through stdin to curl with "-d -", but according to
	# the curl docs, it needs to submitted like this: "-d @-"
	local req = ActiveHTTP::Request($url=url,
	                                $method="POST",
	                                #$client_data=data_string,
	                                $addl_curl_args="-d '" + data_string + "' -H 'Phant-Private-Key: " + p$private_key + "'");
	return when ( local r =  ActiveHTTP::request(req) )
		{
		return r$body[0] == "1";
		}

	}