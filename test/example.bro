redef exit_only_after_terminate=T;

@load ../

type MyData: record {
	a: double;
	b: count;
};

global p = Phant::new($private_key="1JJKdl7V5nFYoDq0gd4B",
                      $public_key="XGGajLdOKWtzOJpA8w6y");

event bro_init()
	{
	when ( local r = Phant::submit(p, [$a=43.21, $b=12]) )
		{
		print "Phant submission " + (r ? "Success!" : "Failure!");
		}
	}