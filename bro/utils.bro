
module Phant;

function convert_to_kv(v: any): string
	{
	local tn = type_name(v);
	switch ( tn )
		{
		case "type":
		return "";

		case "string":
		return gsub(gsub(clean(v), /\\/, "\\\\"), /\"/, "\\\"");

		case "addr":
		fallthrough;
		case "port":
		return cat("\"", v, "\"");

		case "int":
		fallthrough;
		case "count":
		fallthrough;
		case "time":
		fallthrough;
		case "double":
		fallthrough;
		case "bool":
		fallthrough;
		case "enum":
		return cat(v);

		default:
		break;
		}

	if ( /^record/ in tn )
		{
		local rec_parts: set[string] = set();

		local ft = record_fields(v);
		for ( field in ft )
			{
			local field_desc = ft[field];
			if ( field_desc?$value )
				{
				local onepart = cat(field, "=", Phant::convert_to_kv(field_desc$value));
				add rec_parts[onepart];
				}
			}
		return cat(join_string_set(rec_parts, "&"));
		}
	
	return "";
	}


