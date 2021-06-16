<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	StringBuilder path = new StringBuilder(request.getContextPath());
	path.append("/");
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>getBoardList.jsp 게시판 구현 - webapp</title>
<jsp:include page="../common/commonUIglobal.jsp" flush= "false"/>
<script>
	function search(){
		console.log("조회 호출");
		$('#dg_board').datagrid({			
			url:'jsonGetBoardList.sp4',
		});
	}
	
	function ins(){
		console.log("입력 호출");
		$('#dlg_ins').dialog('open');
	}
	
	function close(){
		$('#dg_board').datagrid({			
			url:'boardInsert.sp4',
		});
		console.log("dialog닫기");
		$('#dlg_ins').dialog('close');
	}
	
</script>
</head>
<body>
	<script type="text/javascript">
		$(document).ready(function(){
			$('#dg_board').datagrid({
				toolbar:'#tb_board2'
			});
		})
		
	</script>
	
	<table id = "dg_board" class = "easyui-datagrid" data-options = "title:'게시판-webapp'" style = "width:500px;height:350px">
	    <thead>
	        <tr>
	            <th data-options="field:'BM_NO'">글번호</th>
	            <th data-options="field:'BM_TITLE'">글제목</th>
	            <th data-options="field:'BM_DATE'">작성일</th>
	            <th data-options="field:'BS_FILE'">첨부파일</th>
	            <th data-options="field:'BM_HIT'">조회수</th>
	        </tr>
	    </thead>
	</table>
	
	<div id="tb_board2" style="padding:2px 5px;">
	        <a href="javascript:search()" class="easyui-linkbutton" iconCls="icon-search" plain="true">조회</a>
	        <a href="javascript:ins()" class="easyui-linkbutton" iconCls="icon-add" plain="true">입력</a>
	        <a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true">수정</a>
	        <a href="#" class="easyui-linkbutton" iconCls="icon-cancel" plain="true">삭제</a>
	</div>
	<!--========================================= 글쓰기 화면 시작 ============================================  -->
	<div id="dlg_ins" class="easyui-dialog" title="글쓰기" data-options="iconCls:'icon-save',closed:'false'" style="width:600px;height:500px;padding:10px">
    	<form action="./boardInsert.sp4">
	    	<div style="margin-bottom:20px">
	            <input name="bm_title" class="easyui-textbox" label="제목" labelPosition="top" style="width:100%;">
	        </div>
	        <div style="margin-bottom:20px">
	            <input name="bm_writer" class="easyui-textbox" label="작성자" labelPosition="top" style="width:100%;">
	        </div>
	        <div style="margin-bottom:20px">
	            <input name="bm_email" class="easyui-textbox" label="email" labelPosition="top"  data-options="prompt:'Enter a email address...',validType:'email'" style="width:100%;">
	        </div>
	        <div style="margin-bottom:20px">
	            <input name="bm_content" class="easyui-textbox" label="내용" labelPosition="top" multiline="true" style="width:100%;height:100px">
	        </div>
	        <div style="margin-bottom:20px">
	            <input name="bs_file" class="easyui-filebox" label="첨부파일" labelPosition="top" style="width:100%;">
	        </div>
	        <div style="margin-bottom:20px">
            	<input name="bm_pw" class="easyui-passwordbox" label = "비밀번호" labelPosition="top" prompt="Password" iconWidth="28" style="width:100%">
        	</div>
	        <div>
	            <input type="submit" class="easyui-linkbutton" iconCls="icon-ok" style="width:100%;height:32px">
	        </div>
    	</form>
        
    </div>
	<!--========================================= 글쓰기 화면 끝 =============================================  -->

</body>
</html>