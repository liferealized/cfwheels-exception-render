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
	
	<cffunction name="sendExceptionEmail" returntype="void" access="public" output="false" mixin="application,dispatch">
		<cfargument name="exception" type="any" required="true">
		<cfargument name="eventName" type="any" required="true">
		<cfscript>	
			var loc = {};
					
			if (application.wheels.sendEmailOnError)
			{
				loc.mailArgs = {};
				loc.mailArgs.from = application.wheels.errorEmailAddress;
				loc.mailArgs.to = application.wheels.errorEmailAddress;
				loc.mailArgs.subject = "Error";
				loc.mailArgs.type = "html";
				loc.mailArgs.body = [$includeAndReturnOutput($template="wheels/events/onerror/cfmlerror.cfm", exception=arguments.exception)];
				$insertDefaults(name="sendEmail", input=loc.mailArgs);
				$mail(argumentCollection=loc.mailArgs);
			}
		</cfscript>
	</cffunction>
	
	<cffunction name="$runOnError" returntype="string" access="public" output="false" mixin="application,dispatch">
		<cfargument name="exception" type="any" required="true">
		<cfargument name="eventName" type="any" required="true">
		<cfscript>
			var loc = {};
	
			if (StructKeyExists(application, "wheels") && StructKeyExists(application.wheels, "initialized"))
			{
				if (application.wheels.showErrorInformation)
				{
					if (StructKeyExists(arguments.exception, "rootCause") && Left(arguments.exception.rootCause.type, 6) == "Wheels")
						loc.wheelsError = arguments.exception.rootCause;
					else if (StructKeyExists(arguments.exception, "cause") && StructKeyExists(arguments.exception.cause, "rootCause") && Left(arguments.exception.cause.rootCause.type, 6) == "Wheels") 
						loc.wheelsError = arguments.exception.cause.rootCause;
					if (StructKeyExists(loc, "wheelsError"))
					{
						loc.returnValue = $includeAndReturnOutput($template="wheels/styles/header.cfm");
						loc.returnValue = loc.returnValue & $includeAndReturnOutput($template="wheels/events/onerror/wheelserror.cfm", wheelsError=loc.wheelsError);
						loc.returnValue = loc.returnValue & $includeAndReturnOutput($template="wheels/styles/footer.cfm");
					}
					else
					{
						$throw(object=arguments.exception);
					}
				}
				else
				{
					loc.returnValue = $includeAndReturnOutput($template="#application.wheels.eventPath#/onerror.cfm", exception=arguments.exception, eventName=arguments.eventName);
				}
			}
			else
			{
				$throw(object=arguments.exception);
			}
		</cfscript>
		<cfreturn loc.returnValue>
	</cffunction>

</cfcomponent>