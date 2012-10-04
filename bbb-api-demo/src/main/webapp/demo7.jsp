<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% 
	request.setCharacterEncoding("UTF-8"); 
	response.setCharacterEncoding("UTF-8"); 
%>
<!DOCTYPE html>
<html> 
 <head>
    <meta charset="utf-8">
    <title>Entrar e fazer Upload da apresentacao</title>
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
 
 	<div class="container-fluid">

	<div class="hero-unit">
		<h2>Entrar e Fazer Upload da apresentacao</h2>
	</div>
	
	 <form action="demo7.jsp" class="well" method="post" enctype="multipart/form-data" name="form1" id="form1">
	 		<INPUT TYPE=hidden NAME=action VALUE="create">
	 		<label>Nome</label>
			<input type="text" autofocus required name="username" />
			<label>Arquivo</label>
			<input type="file" name="filename" />
			<div class="form-actions">
		       	<input type="submit" value="Entrar" class="btn btn-primary"/>
		    </div>
	</form>
	</div>
	
    <%@ page import="java.util.List" %>
	<%@ page import="java.util.Iterator" %>
	<%@ page import="java.io.File" %>
	<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
	<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
	<%@ page import="org.apache.commons.fileupload.*"%>
	<%@page import="sun.security.provider.SHA"%>
	<%@page import="org.apache.commons.codec.binary.Base64"%>
	<%@page import="java.security.MessageDigest"%>
 <%
     String uname="";	 
 boolean isMultipart = ServletFileUpload.isMultipartContent(request);
 
 if (!isMultipart) {
 } 
 else {
   FileItemFactory factory = new DiskFileItemFactory();
   ServletFileUpload upload = new ServletFileUpload(factory);
   List<FileItem> items = null;
   try {
	   items = upload.parseRequest(request);
   } catch (FileUploadException e) {
		e.printStackTrace();
   }
   out.print(items.size());
   Iterator<FileItem> itr = items.iterator();
   while (itr.hasNext()) {
	   FileItem item = (FileItem) itr.next();
		String xml = null;
 		// String url = BigBlueButtonURL.replace("bigbluebutton/","demo/");
		// String preUploadPDF = "<?xml version='1.0' encoding='UTF-8'?><modules><module name='presentation'><document url='"+url+"pdfs/sample.pdf'/></module></modules>";
 
		// xml = preUploadPDF;
	   if (item.isFormField())
		   {
		      String name = item.getFieldName();
			  String value = item.getString();
			  if(name.equals("username"))
		           {
				   uname=value;
				   }
	   } else  { 
		try {
		
			String itemName = item.getName();
			 
			if(itemName!=""){
				byte[] b = item.get();
				String encoded = Base64.encodeBase64String(b); 
				xml = "<?xml version='1.0' encoding='UTF-8'?><modules><module name=\"presentation\"><document name=\""+itemName+"\">"+encoded+"\"</document></module></modules>";
			}
		} catch (Exception e) {
		   e.printStackTrace();
	    }

		 String welcome = "<br>Bem vindo a conferencia <b>%%CONFNAME%%</b>!";
		 String welcomeMsg = "A apresentacao enviada sera apresentada em instantes.<br>" + welcome;

		
		String joinURL = getJoinURLXML(uname, "Entrar e Enviar Apresentacao", welcomeMsg, xml );
		if (joinURL.startsWith("http://")) { 
			%>
			<script language="javascript" type="text/javascript">
			  window.location.href="<%=joinURL%>";
			</script>

			<%
			} else {
			%>

			Error: getJoinURL() failed
			<p />
			<%=joinURL %>
				<% 
					}
		 }
   }
   }
   %>
   
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


