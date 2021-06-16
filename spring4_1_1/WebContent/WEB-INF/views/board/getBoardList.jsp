<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>    
<%
	StringBuilder path = new StringBuilder(request.getContextPath());
	path.append("/");
	List<Map<String,Object>> boardList = null;
	boardList = (List<Map<String,Object>>)request.getAttribute("boardList");
	int size = 0;
	if(boardList!=null){
		size = boardList.size();
	}
	out.print("size:"+size);
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 목록[WEB-INF]</title>
<!-- jEasyUI 시작 -->
<link rel="stylesheet" type="text/css" href="<%=path.toString() %>themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=path.toString() %>themes/icon.css"> 
<!-- jEasyUI JS 시작 -->
<script type="text/javascript" src="<%=path.toString() %>js/jquery.min.js"></script>
<script type="text/javascript" src="<%=path.toString() %>js/jquery.easyui.min.js"></script>   
<script type="text/javascript">
	function boardSel(){
		$('#dg_board').datagrid({
		    url:'./jsonGetBoardList.sp4'
           ,onLoadSuccess: function(){
       			alert("조회 호출 성공");
    		}		    
		});			
	}
    function ins(){
	    console.log("입력창 호출");
	    $('#dlg_ins').dialog('open');
	}
    function insAction(){
    	console.log("글쓰기 저장 버튼 클릭");
    	$('#board_ins').submit();
    }
	function boardIns(){
		
	}
	function boardUpd(){
		
	}
	function boardDel(){
		
	}
</script>
</head>
<body>
<script type="text/javascript">
	$(document).ready(function(){
		$('#dg_board').datagrid({
		    columns:[[
		        {field:'BM_NO',title:'글번호',width:100,align:'center'},
		        {field:'BM_TITLE',title:'제목',width:400,align:'left'},
		        {field:'BM_DATE',title:'작성일',width:150,align:'center'},
		        {field:'BS_FILE',title:'첨부파일',width:230,align:'center'},
		        {field:'BM_HIT',title:'조회수',width:100,align:'center'}
		    ]]
		});		
	    $('#btn_sel').bind('click', function(){
	        //alert('조회');
	        boardSel();
	    });		
	    $('#btn_ins').bind('click', function(){
	        //alert('입력');
	        boardIns();
	    });		
	    $('#btn_upd').bind('click', function(){
	        //alert('수정');
	        boardUpd();
	    });		
	    $('#btn_del').bind('click', function(){
	        //alert('삭제');
	        boardDel();
	    });		
	});
</script>
<table id="dg_board" class="easyui-datagrid" data-options="title:'게시판',toolbar:'#tb_board', width:1000">
    <thead>
        <tr>
            <th data-options="field:'BM_NO', width:100">글번호</th>
            <th data-options="field:'BM_TITLE', width:100">제목</th>
            <th data-options="field:'BM_DATE', width:100">작성일</th>
            <th data-options="field:'BS_FILE', width:100">첨부파일</th>
            <th data-options="field:'BM_HIT', width:100">조회수</th>
        </tr>
    </thead>
    <tbody>
<%
//조회 결과가 없는 거야?
if(size==0){		
%>    
        <tr>
            <td colspan="5">조회결과가 없습니다.</td>
        </tr>
<%
}
else{//조회 결과가 있는데....
	for(int i=0;i<size;i++){
		Map<String,Object> rmap = boardList.get(i);
		if(i==size) break;
%>    	
        <tr>
            <td><%=rmap.get("BM_NO") %></td>
<!-- 너 댓글이니? -->       
<%
	String imgPath = "\\board\\";
	if(Integer.parseInt(rmap.get("BM_POS").toString()) >0 ){
		for(int j=0;j<Integer.parseInt(rmap.get("BM_POS").toString());j++){
			out.print("&nbsp;&nbsp;");
		}
%>   
	<!-- 여기는 html 땅이다.  -->
	<img src="<%=imgPath %>reply.gif" border="0">	
<%
	}/////////////////end of if
%>  
            <td><a href="getBoardDetail.sp4?bm_no=<%=rmap.get("BM_NO")%>" style="text-decoration:none;"><%=rmap.get("BM_TITLE") %></a></td>
            
            <td><%=rmap.get("BM_DATE") %></td>
            <td><a href="./download.jsp?bs_file=<%=rmap.get("BS_FILE") %>" style="text-decoration:none;"><%=rmap.get("BS_FILE") %></a></td>
            <td><%=rmap.get("BM_HIT") %></td>
        </tr>
<%
	}/////////////end of for
}/////////////////end of else
%>
    </tbody>
</table>
    <div id="tb_board" style="padding:2px 5px;">
        <a id="btn_sel" href="#" class="easyui-linkbutton" iconCls="icon-search" plain="true">조회</a>
        <a id="btn_ins" href="javascript:ins()" class="easyui-linkbutton" iconCls="icon-add" plain="true">입력</a>
        <a id="btn_upd" href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true">수정</a>
        <a id="btn_del" href="#" class="easyui-linkbutton" iconCls="icon-cancel" plain="true">삭제</a>
    </div>   
    <!--=========================== [[글쓰기 화면 시작]] =============================-->
    <div id="dlg_ins" class="easyui-dialog" title="글쓰기" data-options="iconCls:'icon-save', closed:true, footer:'#ft_ins'" style="width:600px;height:650px;padding:10px">
    	<form id="board_ins" method="post" enctype="multipart/form-data" action="./boardInsert.sp4">    
    	<input type="hidden" name="bm_no" value="0">
    	<input type="hidden" name="bm_group" value="0">
    	<input type="hidden" name="bm_pos" value="0">
    	<input type="hidden" name="bm_step" value="0">
        <div style="margin-bottom:20px">
            <input class="easyui-textbox" name="bm_title" label="제목:" labelPosition="top" data-options="prompt:'제목'" style="width:400px;">
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-textbox"  name="bm_writer" label="작성자:" labelPosition="top" data-options="prompt:'작성자'" style="width:250px;">
        </div>        
        <div style="margin-bottom:20px">
            <input class="easyui-textbox"  name="bm_content" label="내용:" labelPosition="top" data-options="prompt:'내용',multiline:true, width:500, height:120">
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-textbox" name="bm_email" label="Email:" labelPosition="top" data-options="prompt:'Enter a email address...',validType:'email'" style="width:100%;">
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-textbox"  name="bm_pw" label="비밀번호:" labelPosition="top" style="width:200;">
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-filebox" label="첨부파일:"  name="bs_file" labelPosition="top" data-options="width:'400px'" >
        </div>
    	</form>
    </div>    
    <div id="ft_ins">
		<a href="javascript:insAction()" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true">저장</a>
		<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel',plain:true">취소</a>
	</div>
    <!--=========================== [[글쓰기 화면   끝 ]] =============================-->  
</body>
</html>