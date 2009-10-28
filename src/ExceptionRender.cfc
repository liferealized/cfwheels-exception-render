<cfcomponent output="false">

	<cffunction name="init" output="false" access="public" returntype="any">
		<cfset this.version = "1.0" />
		<cfreturn this />
	</cffunction>
	
	<cffunction name="exceptionRender" output="false" access="public" returntype="string" mixin="application,dispatch">
		<cfargument name="route" type="string" required="false" default="" hint="See documentation for @URLFor" />
		<cfargument name="controller" type="string" required="false" default="" hint="See documentation for @URLFor" />
		<cfargument name="action" type="string" required="false" default="" hint="See documentation for @URLFor" />
		<cfargument name="key" type="any" required="false" default="" hint="See documentation for @URLFor" />
		<cfargument name="params" type="string" required="false" default="" hint="See documentation for @URLFor" />
		<cfscript>
			var loc = {
				url = ReplaceList(URLFor(argumentCollection=arguments), "/index.cfm,/rewrite.cfm", ",")
			};
		
			request.cgi.path_info = loc.url;
		
			StructDelete(url, "action");
			StructDelete(url, "controller");
			StructDelete(url, "route");
		</cfscript>
		<cfreturn application.wheels.dispatch.$request() />
	</cffunction>

</cfcomponent>