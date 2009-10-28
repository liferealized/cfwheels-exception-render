<h1>Exception Render</h1>

<p>This plugin adds a new method that can be used in "/events/onerror.cfm", "/events/onmaintenance" and "/events/onmissingmethod.cfm" to reuse the wheels framework to render exception pages. The methods include:</p>
<ul>
	<li><code>exceptionRender(route, controller, action, key, params)</code></li>

</ul> 

<p>Call this method from from the files listed above to reuse 100% of your existing code. This plugin has a couple of benefits which include:</p>

<ul>
	<li>Response codes 404 and 500 are preserved.</li>
	<li>100% reuse of your existing layouts and templates. No need to duplicate your layouts in onerror.cfm and onmissingtemplate.cfm</li>
	<li>Coldfusion still catches errors that occur in onerror() and onMissingMethod() so you application will never hang from errors created inside of the error trapping system.</li>
</ul>


<p>If you have a complex application this can save you time since you would no longer need to duplicate layouts, templates, etc.</p>

<h2>Examples</h2>
<p>Just put the one of the code samples below into the files listed at the top to render error pages.</p>

<p>
	<code>
		<pre>
&lt;cfoutput&gt;
	#exceptionRender(route="yourExceptionRoute", action="yourExceptionAction")#
&lt;/cfoutput&gt;	
		</pre>
	</code>
</p>

<p>- or -</p>

<p>Just put the one of the code samples below into the files listed at the top to render error pages.</p>

<p>
	<code>
		<pre>
&lt;cfscript&gt;
	#WriteOutput(exceptionRender(route="yourExceptionRoute", action="yourExceptionAction"))#
&lt;/cfscript&gt;	
		</pre>
	</code>
</p>

<h2>Uninstallation</h2>
<p>To uninstall this plugin simply delete the <tt>/plugins/ExceptionRender-0.1.zip</tt> file.</p>

<h2>Credits</h2>
<p>This plugin was created by <a href="http://iamjamesgibson.com">James Gibson</a>.</p>


<p><a href="<cfoutput>#cgi.http_referer#</cfoutput>">&lt;&lt;&lt; Go Back</a></p>