<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
	StringBuilder path = new StringBuilder(request.getContextPath());
	path.append("/");
	List<Map<String, Object>> boardList = null;
	boardList = (List<Map<String, Object>>)request.getAttribute("boardList");
	int size = 0;
	if(boardList != null){
		size = boardList.size();
	}
	out.print("size : " + size);
	
%>           
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>getBoardList.jsp 게시판 구현 - [WEB-INF]</title>
<!-- jEasyUI 시작 -->
<link rel="stylesheet" type="text/css" href="../../../themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="../../../themes/icon.css"> 
<!-- jEasyUI JS 시작 -->
<script type="text/javascript" src="../../../js/jquery.min.js"></script>
<script type="text/javascript" src="../../../js/jquery.easyui.min.js"></script>   
<script type="text/javascript">
	function boardSel(){
		$('#dg_board').datagrid({
// 			url:'./jsonGetBoardList.sp4'
			url:'./getBoardList.sp4'
			,onLoadSuccess: function(){
				alert("조회성공");
			}
		});
	}
	function boardIns(){
// 		$('#dg_board').datagrid({
// 			url:'./boardInsert.sp4'			
// 		}).dialog('open');
		console.log("입력 호출"+$('#dlg_ins'));
		$('#dlg_ins').dialog('open');
	}
	function boardUpd(){
// 		$('#dg_board').datagrid({
// 			url:'./boardUpdate.sp4'			
// 		});
	console.log("boardUpd 호출 성공");
	
		$('#dlg_upd').dialog('open');
	}
	function boardDel(){
		$('#dg_board').datagrid({
			url:'./boardDelete.sp4'			
		});				
	}
    function submit(){
        $('#board_ins').form('submit');
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
			]],
			onDblClickCell: function(index, field, value){
				if("BS_FILE" == field){
					location.href="./download.jsp?b_file="+value;
				}
			}
		});
	    $('#btn_sel').bind('click', function(){
	    	console.log("조회 버튼 클릭");
	        boardSel();
	    });
	    $('#btn_ins').bind('click', function(){
	    	console.log("입력 버튼 클릭");
	        boardIns();
	    });
	    $('#btn_upd').bind('click', function(){
	    	console.log("수정 버튼 클릭");
	        boardUpd();
	    });
	    $('#btn_del').bind('click', function(){
	    	console.log("삭제 버튼 클릭");
	        boardDel();
	    });
	});
</script>
<table id = "dg_board" class = "easyui-datagrid" data-options = "title:'게시판-[WEB-INF]',toolbar:'#tb_board'" style = "width:1000px;height:350px">
    <thead>
        	        <tr>
	            <th data-options="field:'BM_NO'">글번호</th>
	            <th data-options="field:'BM_TITLE'">글제목</th>
	            <th data-options="field:'BM_DATE'">작성일</th>
	            <th data-options="field:'BS_FILE'">첨부파일</th>
	            <th data-options="field:'BM_HIT'">조회수</th>
	        </tr>
    </thead>
    
    <tbody>
    <%
    	if(size == 0){	// 조회 결과가 없는 경우
    %>
        <tr>
            <td colspan="5">조회결과가 없습니다</td>
        </tr>
	<%
    	}
    	else{	// 조회 결과가 있는 경우
    		for(int i = 0; i < size; i++){
    			Map<String, Object> rmap = boardList.get(i);
    			if(i == size) break;
	%>    
        <tr>
            <td><%=rmap.get("BM_NO") %></td>
<!-- 너 댓글이니? -->
<%
	String imgPath = "\\board\\";
	if(Integer.parseInt(rmap.get("BM_POS").toString()) > 0){
		for(int j=0; j<Integer.parseInt(rmap.get("BM_POS").toString()); j++){
			out.print("$nbsp;&nbsp;");
		}
%>
		<!-- 여기는 html의 땅이다. -->
		<img src="<%=imgPath %>reply.gif>" border="0">
<%
	}/////////////////end of if
%>
            <td><a href="./getBoardDetail.sp4?bm_no=<%=rmap.get("BM_NO") %>" style="text-decoration:none;"><%=rmap.get("BM_TITLE") %></a></td>
<%--             <td><a href="javascript:boardIns()"><%=rmap.get("BM_TITLE") %></a></td> --%>
            <td><%=rmap.get("BM_DATE") %></td>
            <td><a href="download.jsp?bs_file=<%=rmap.get("BS_FILE") %>" style="text-decoration:none;"><%=rmap.get("BS_FILE") %></a></td>
            <td><%=rmap.get("BM_HIT") %></td>
<!--             <td data-options="field:'BM_NO'">글번호</td> -->
<!--             <td data-options="field:'BM_TITLE'">글제목</td> -->
<!--             <td data-options="field:'BM_DATE'">작성일</td> -->
<!--             <td data-options="field:'BS_FILE'">첨부파일</td> -->
<!--             <td data-options="field:'BM_HIT'">조회수</td> -->
        </tr>
    <%
    		}/////////////////////end of for
    	}/////////////////////////end of if-else
    %>
    </tbody>
</table>
<div id="tb_board" style="padding:2px 5px;">
        <a id="btn_sel" href="#" class="easyui-linkbutton" iconCls="icon-search" plain="true">조회</a>
        <a id="btn_ins" href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true">입력</a>
        <a id="btn_upd" href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true">수정</a>
        <a id="btn_del" href="#" class="easyui-linkbutton" iconCls="icon-cancel" plain="true">삭제</a>
</div>
<!--===================== 입력(글쓰기)을 위한 모달창 시작 =====================-->
<div id="dlg_ins" class="easyui-dialog" title="글쓰기" style="width:fit-content" data-options="closed:true, footer:'#ft_ins'">
	<form id="board_ins" method="post" action="boardInsert.sp4" enctype="multipart/form-data">
	<input type="hidden" name="bm_no" value="0">
	<input type="hidden" name="bm_group" value="0">
	<input type="hidden" name="bm_pos" value="0">
	<input type="hidden" name="bm_step" value="0">
        <div style="margin: 10px; margin-bottom:20px">
            <input class="easyui-textbox" name="bm_title" label="제목:" labelPosition="top" data-options="prompt:'제목'" style="width:400px;">
        </div>
        <div style="margin: 10px; margin-bottom:20px">
            <input class="easyui-textbox" name="bm_writer" label="작성자:" labelPosition="top" data-options="prompt:'작성자'" style="width:250px;">
        </div>        
        <div style="margin: 10px; margin-bottom:20px">
            <input class="easyui-textbox" name="bm_content" label="내용:" labelPosition="top" data-options="prompt:'내용',multiline:true, width:500, height:120">
        </div>
        <div style="margin: 10px; margin-bottom:20px">
            <input class="easyui-textbox" name="bm_email" label="Email:" labelPosition="top" data-options="prompt:'Enter a email address...',validType:'email'" style="width:100%;">
        </div>
        <div style="margin: 10px; margin-bottom:20px">
            <input class="easyui-passwordbox" name="bm_pw" label="비밀번호:" labelPosition="top" style="width:200;">
        </div>
        <div style="margin: 10px; margin-bottom:20px">
            <input class="easyui-filebox" name="bs_file" label="첨부파일:" labelPosition="top" data-options="width:'400px'" >
        </div>
	</form>
</div>
<div id="ft_ins" style="text-align:right;">
	<a href="#" class="easyui-linkbutton" text="저장" onclick="javascript:submit()" data-options="iconCls:'icon-save',plain:true"></a>
	<a href="#" class="easyui-linkbutton" text="취소" data-options="iconCls:'icon-cancel',plain:true"></a>
</div>
<!--===================== 입력(글쓰기)을 위한 모달창 종료 =====================-->
<!--===================== 글수정을 위한 모달창 종료 =====================-->
<div id="dlg_upd" class="easyui-dialog" title="글수정" style="width:fit-content;" data-options="closed:true">
<%-- 	<jsp:include page="./read.jsp"/> --%>
</div>
<!--===================== 글수정을 위한 모달창 종료 =====================-->

</body>
</html>