<!DOCTYPE html>
<html> 
 <head>
    <meta charset="utf-8">
    <title>Entrar & Enviar Apresentacao (URL)</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- Le styles -->
    <link href="<%=request.getContextPath()%>/assets/css/bootstrap.css" rel="stylesheet">
    <style>
      body {
        padding-top: 60px; /* 60px to make the container go all the way to the bottom of the topbar */
      }
    </style>
    <link href="<%=request.getContextPath()%>/assets/css/bootstrap-responsive.css" rel="stylesheet">
    <link href="<%=request.getContextPath()%>/assets/css/docs.css" rel="stylesheet">

    <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

    <!-- Le fav and touch icons -->
    <link rel="shortcut icon" href="<%=request.getContextPath()%>/assets/ico/favicon.ico">
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="<%=request.getContextPath()%>/assets/ico/logo_icone.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="<%=request.getContextPath()%>/assets/ico/logo_icone.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="<%=request.getContextPath()%>/assets/ico/logo_icone.png">
    <link rel="apple-touch-icon-precomposed" href="<%=request.getContextPath()%>/assets/ico/logo_icone.png">
  </head>
 <body>
 <%@ include file="bbb_api.jsp"%>  

<%
	String welcome = "<br>Bem vindo a <b>%%CONFNAME%%</b>!";

        if (request.getParameterMap().isEmpty()) {
		HashMap<String, String> presentations = new HashMap<String, String>();

		presentations.put( "Virtools.pptx", "Virtools.pptx" );
		presentations.put( "apresentacao1.pdf", "pdfs/apresentacao1.pdf" );
		presentations.put( "apresentacao2.pdf", "pdfs/apresentacao2.pdf" );
		presentations.put( "apresentacao3.pdf", "pdfs/apresentacao3.pdf" );
%>

<%@ include file="demo_header.jsp"%>

	<div class="container-fluid">

	<div class="hero-unit">
		<h2>Entrar & Enviar Apresentacao (URL)</h2>
	</div>
	<form name="form1" method="get" class="well">
		<INPUT TYPE=hidden NAME=action VALUE="create">
		<label>Nome</label>
		<input type="text" autofocus required name="username" />
   		<label>Preenviar</label>
    	<select name=presentationFileName>
                        <%
				Iterator<String> presentationsIterator = new TreeSet<String>(presentations.keySet()).iterator();
				String key;

                                while (presentationsIterator.hasNext()) {
                                        key = presentationsIterator.next();
                                        out.println("<option value=\"" + presentations.get(key) + "\">" + key + "</option>");
                                }

                        %>
		</select>
		<div class="form-actions">
		   <input type="submit" value="Entrar" class="btn btn-primary"/>
		</div>		
	</form>
	</div>
	  	<%@ include file="demo_footer.jsp"%>

    <script src="<%=request.getContextPath()%>/assets/js/jquery.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/bootstrap-transition.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/bootstrap-alert.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/bootstrap-modal.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/bootstrap-dropdown.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/bootstrap-scrollspy.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/bootstrap-tab.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/bootstrap-tooltip.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/bootstrap-popover.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/bootstrap-button.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/bootstrap-collapse.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/bootstrap-carousel.js"></script>
    <script src="<%=request.getContextPath()%>/assets/js/bootstrap-typeahead.js"></script>
 </body>
</html>

<%
} else if (request.getParameter("action").equals("create")) {
        
         // Got an action=create
  
        String username = request.getParameter("username");
        String presentationFileName = request.getParameter("presentationFileName");
	
	String demoURL = BigBlueButtonURL.replace("bigbluebutton/","demo/");
	String xml = "<?xml version='1.0' encoding='UTF-8'?> <modules>	<module name='presentation'> <document url='"+demoURL+presentationFileName+"' /> </module></modules>";
	String welcomeMsg = "A apresentacao sera carregada em instantes.  Para fazer o download <a href=\"event:"+ demoURL+presentationFileName+ "\"><u>" + presentationFileName +"</u></a>.<br>" + welcome;

	String meetingID = presentationFileName.replace("pdfs/","").replace(".pdf","").replace(".pptx","");
	String joinURL = getJoinURL(username, meetingID, "false", welcomeMsg, null, xml );

	if (joinURL.startsWith("http://")) { 
		%>
		<script language="javascript" type="text/javascript">
		  window.location.href="<%=joinURL%>";
		</script>

		<%
		} else {
		%>

		Erro: getJoinURL() falhou
		<p />
		<%=joinURL %>
			<% 
				}
}
%>
</body>
</html>
