<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	StringBuilder path = new StringBuilder(request.getContextPath());
	path.append("/");	
	String bm_no = request.getParameter("bm_no");
	String bm_title = request.getParameter("bm_title");
	String bs_file = request.getParameter("bs_file");
	String bm_writer = request.getParameter("bm_writer");
	String bm_content = request.getParameter("bm_content");
	out.print(bm_no+", "+bm_writer+", "+bm_content+", "+bs_file);
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="<%=path.toString() %>themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=path.toString() %>themes/icon.css"> 
<!-- jEasyUI JS 시작 -->
<script type="text/javascript" src="<%=path.toString() %>js/jquery.min.js"></script>
<script type="text/javascript" src="<%=path.toString() %>js/jquery.easyui.min.js"></script> 
<script type="text/javascript">
	function updAction(){
		console.log("수정액션 호출");
		$('#board_upd').submit();
	}	
</script>
</head>
<body>
	<script type="text/javascript">
		$(document).ready(function(){
			$('#ubm_title').textbox('setValues', '<%=bm_title%>');
			$('#ubm_writer').textbox('setValues', '<%=bm_writer%>');
			$('#ubm_content').textbox('setValues', '<%=bm_content%>');
		});
	</script>
    <!--=========================== [[글수정 화면 시작]] =============================-->

    	<form id="board_upd" method="post" action="boardUpdate.sp4">    
    	<input type="hidden" name="bm_no" value="<%=bm_no%>">
    	<input type="hidden" name="bs_file" value="<%=bs_file%>">
        <div style="margin-bottom:20px">
            <input class="easyui-textbox" id="ubm_title" label="제목:" labelPosition="top" data-options="prompt:'제목'" style="width:400px;">
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-textbox"  id="ubm_writer" label="작성자:" labelPosition="top" data-options="prompt:'작성자'" style="width:250px;">
        </div>        
        <div style="margin-bottom:20px">
            <input class="easyui-textbox"  id="ubm_content" label="내용:" labelPosition="top" data-options="prompt:'내용',multiline:true, width:500, height:120">
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-textbox" id="ubm_email" label="Email:" labelPosition="top" data-options="prompt:'Enter a email address...',validType:'email'" style="width:100%;">
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-textbox"  id="ubm_pw" label="비밀번호:" labelPosition="top" style="width:200;">
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-filebox" label="첨부파일:"  id="ubs_file" labelPosition="top" data-options="width:'400px'" >
        </div>
    	</form> 
    <div id="ft_ins">
		<a href="javascript:updAction()" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true">수정</a>
		<a href='javascript:$("#dlg_upd").dialog("close");' class="easyui-linkbutton" data-options="iconCls:'icon-cancel',plain:true">닫기</a>
	</div>
    <!--=========================== [[글수정 화면   끝 ]] =============================--> 
</body>
</html>