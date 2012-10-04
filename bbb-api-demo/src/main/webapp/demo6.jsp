<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8"); 
	response.setCharacterEncoding("UTF-8"); 
%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Gravar (Matterhorn)</title>
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
<%@ include file="demo_header.jsp"%>

<%
	if (request.getParameterMap().isEmpty()) {
%>
<div class="container-fluid">
	<div class="hero-unit">
		<h2>Gravar (Matterhorn)</h2>
	</div>

	<form id="formcreate" class="well" name="formcreate" method="get" action=""> 
		<input type="hidden" name="action" value="create" />
		<fieldset>
			<legend>Informacoes da Reuniao</legend>
				<label for="confname">Nome da Reuniao:</label>
				<input id="confname" autofocus required name="confname" type="text" />
				<label for="username1">Seu nome:</label>
				<input id="username1" required name="username1" type="text" />	
		</fieldset>
		
		<fieldset>
			<legend>Detalhes</legend>
				<label for="meta_title">Titulo</label>
				<input type="text" id="meta_title" name="meta_title" />	
				<label for="meta_subject">Assunto</label>
				<input type="text" id="meta_subject" name="meta_subject" />
				<label id="labdescription" for="meta_description">Descricao</label>
				<textarea id="meta_description" name="meta_description" cols="17" rows="3"></textarea>
				<label for="meta_creator">Criador</label>
				<input type="text" id="meta_creator" name="meta_creator" />
				<label for="meta_contributor">Contribuidor</label>
				<input type="text" id="meta_contributor" name="meta_contributor" />
				<label for="meta_language">Linguagem</label>
				<input type="text" id="meta_language" name="meta_language" />
				<label for="meta_identifier">Identificador</label>
				<input type="text" id="meta_identifier" name="meta_identifier" />
		</fieldset>
		
		<div class="form-actions">
	       	<input type="submit" value="Criar" class="btn btn-primary"/>
	    </div>
	</form>

<%
	} else if (request.getParameter("action").equals("create")) {
		
		String confname = request.getParameter("confname");
		String username = request.getParameter("username1");
		
		//metadata
		Map<String,String> metadata=new HashMap<String,String>();
		
		metadata.put("title",request.getParameter("meta_title"));
		metadata.put("subject",request.getParameter("meta_subject"));
		metadata.put("description",request.getParameter("meta_description"));
		metadata.put("creator",request.getParameter("meta_creator"));
		metadata.put("contributor",request.getParameter("meta_contributor"));
		metadata.put("language",request.getParameter("meta_language"));
		metadata.put("identifier",request.getParameter("meta_identifier"));

		//
		// This is the URL for to join the meeting as moderator
		//
		String url = BigBlueButtonURL.replace("bigbluebutton/","demo/");
		String preUploadPDF = "<?xml version='1.0' encoding='UTF-8'?><modules><module name='presentation'><document url='"+url+"pdfs/matterhorn.pdf'/></module></modules>";
		String joinURL = getJoinURL(username, confname, "true", null, metadata, preUploadPDF);

		if (joinURL.startsWith("http://")) { 
%>

<script language="javascript" type="text/javascript">
  window.location.href="<%=joinURL%>";
</script>

<%
	} else {
%>

Error: getJoinURL() failed
<p/>
<%=joinURL %>

<% 
	}
} 
%>
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
