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
<jsp:include page="../../../common/commonUIglobal.jsp" flush= "false"/>
<jsp:include page="./readscript.jsp" flush= "false"/>
<!-- <script type="text/javascript" src="./readscript.jsp"></script> -->
<!-- <script type="text/javascript" src="../../../common/commonUIglobal.jsp"></script> -->
<script type="text/javascript">
	function boardIns(){
		console.log("입력 호출");
		$("#dlg_ins").dialog('open');
	}
	function boardSel(){
		$('#dg_board').datagrid({
// 			url:'./jsonGetBoardList.sp4'
			url:'./getBoardList.sp4'
			,onLoadSuccess: function(){
				alert("조회성공");
			}
		});
	}
// 	function boardIns(){
// 		$('#dg_board').datagrid({
// 			url:'./boardInsert.sp4'			
// 		});
// 	}
	
	function boardUpd(){
		const rows = $('#dg_board').datagrid('getSelections');
		if(rows.length > 1){
			$.messager.confirm('Confirm','하나만 선택해주세요');
		}
		else if(rows.length == 0){			
			$.messager.confirm('Confirm','수정할 항목을 선택해주세요');
		}
		else{
			let row = rows[0].BM_NO.trim();
// 			$('#dlg_edit').attr('url', './getBoardList.sp4?bm_no='+row);
			$('#dlg_edit').dialog({
				closed: false,
				modal: true,
				href: './getBoardDetail.sp4?bm_no='+row
			});
// 			$('#modal_bm_no').attr('value', row);
// 			console.log(row);
// 			$('#board_pw').submit();
// 			location.href = './boardUpdate.sp4?bm_no=' + row
		}
	}
	function boardDel(){
		console.log('삭제');
// 		$('#dg_board').datagrid({
			const rows = $('#dg_board').datagrid('getSelections');
			let row = "";
			for(let i = 0; i < rows.length; i++){
				if(i != rows.length){
					row = row + rows[i].BM_NO.trim() + "cutter";					
				}
				else{
					row = row + rows[i].BM_NO.trim();										
				}
			}
				location.href ='./boardManagerDelete.sp4?bm_no=' + row
// 		});				
	}
	function boardsubmit(){
		$('#board_ins').submit();
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
// 			onDbClickCell: function(index, field, value){
// 				if("BS_FILE" == field){
// 					location.href = "download.jsp?bs_file="+value;
// 				}
// 			}
		});
	    $('#btn_sel').bind('click', function(){
	        boardSel();
	    });
// 	    $('#btn_ins').bind('click', function(){
// 	        boardIns();
// 	    });
// 	    $('#btn_upd').bind('click', function(){
// 	        boardUpd();
// 	    });
// 	    $('#btn_del').bind('click', function(){
// 	        boardDel();
// 	    });

	});
</script>
<table id = "dg_board" class = "easyui-datagrid" data-options = "title:'게시판-[WEB-INF]',toolbar:'#tb_board'" style = "width:1000px;height:350px;">
    <thead>
<!--         <tr> -->
<!--             <th>글번호</th> -->
<!--             <th>제목</th> -->
<!--             <th>작성일</th> -->
<!--             <th>첨부파일</th> -->
<!--             <th>조회수</th> -->
<!--         </tr> -->
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
    	if(size == 0){
    %>
        <tr>
            <td colspan="5">조회결과가 없습니다</td>
        </tr>
	<%
    	}
    	else{
    		for(int i = 0; i < size; i++){
    			Map<String, Object> rmap = boardList.get(i);
    			if(i == size) break;
	%>    
        <tr>
            <td>
            <%=rmap.get("BM_NO") %>
            </td>
            <!-- 너 댓글이니? -->
            <td>
            <%
//             	String imgPath = "\\board\\";
            	String imgPath = "..\\images\\";
            	if(Integer.parseInt(rmap.get("BM_POS").toString()) > 0){
            		for(int j = 0; j < Integer.parseInt(rmap.get("BM_POS").toString()); j++){
            			out.print("&nbsp;&nbsp;");
            		}
            %>
            <img src="<%=imgPath%>reply.gif" border="0">
            <%
    			}
            %>
            <a href="./getBoardDetail.sp4?bm_no=<%=rmap.get("BM_NO") %>" style= "text-decoration:none;"><%=rmap.get("BM_TITLE") %></a></td>
            <td><%=rmap.get("BM_DATE") %></td>
            <%
            	if(!rmap.get("BS_FILE").equals("해당없음")){
            %>
            <td><a href="./download.jsp?b_file=<%=rmap.get("BS_FILE") %>" style= "text-decoration:none;"><%=rmap.get("BS_FILE") %></a></td>
            <%
            	}else{
            %>
<%--             <td><a href="javascript:download(<%=rmap.get("BS_FILE") %>)"><%=rmap.get("BS_FILE") %></a></td> --%>
            <td><%=rmap.get("BS_FILE") %></td>
            <%
            	} 
            %>
            
            <td><%=rmap.get("BM_HIT") %></td>
<!--             <td data-options="field:'BM_NO'">글번호</td> -->
<!--             <td data-options="field:'BM_TITLE'">글제목</td> -->
<!--             <td data-options="field:'BM_DATE'">작성일</td> -->
<!--             <td data-options="field:'BS_FILE'">첨부파일</td> -->
<!--             <td data-options="field:'BM_HIT'">조회수</td> -->
        </tr>
    <%
    		}
    	}
    %>
    </tbody>
</table>
<div id="tb_board" style="padding:2px 5px;">
        <a id="btn_sel" href="#" class="easyui-linkbutton" iconCls="icon-search" plain="true">조회</a>
        <a id="btn_ins" href="javascript:boardIns()" class="easyui-linkbutton" iconCls="icon-add" plain="true">입력</a>
        <a id="btn_upd" href="javascript:boardUpd()" class="easyui-linkbutton" iconCls="icon-edit" plain="true">수정</a>
        <a id="btn_del" href="javascript:boardDel()" class="easyui-linkbutton" iconCls="icon-cancel" plain="true">삭제</a>
</div>
<!--========================================= 글쓰기 화면 시작 ============================================  -->
	<div id="dlg_ins" class="easyui-dialog" title="글쓰기" data-options="iconCls:'icon-save',closed:'false',resizable:true,modal:true, footer:'#ft_ins'" style="width:600px;height:500px;padding:10px;">
    	<form id="board_ins" action="./boardInsert.sp4" method = "post" enctype = "multipart/form-data">
<!--     	<input type="hidden" name="bm_group" value="0">  -->
<!--     	<input type="hidden" name="bm_pos" value="0">  -->
<!--     	<input type="hidden" name="bm_step" value="0">  -->
	    	<div style="margin-bottom:20px">
	            <input name="bm_title" class="easyui-textbox" label="제목" required="required" labelPosition="top" style="width:100%;">
	        </div>
	        <div style="margin-bottom:20px">
	            <input name="bm_writer" class="easyui-textbox" label="작성자" required="required" labelPosition="top" style="width:100%;">
	        </div>
	        <div style="margin-bottom:20px">
	            <input name="bm_email" class="easyui-textbox" label="email" labelPosition="top"  data-options="prompt:'Enter a email address...',validType:'email'" style="width:100%;">
	        </div>
	        <div style="margin-bottom:20px">
	            <input name="bm_content" class="easyui-textbox" label="내용" labelPosition="top" multiline="true" style="width:100%;height:100px;">
	        </div>
	        <div style="margin-bottom:20px">
	            <input name="bs_file" class="easyui-filebox" label="첨부파일" labelPosition="top" style="width:100%;">
	        </div>
	        <div style="margin-bottom:20px">
            	<input name="bm_pw" class="easyui-passwordbox" label = "비밀번호" labelPosition="top" required="required" prompt="Password" iconWidth="28" style="width:100%;">
        	</div>
<!-- 	        <div> -->
<!-- 	            <input type="submit" class="easyui-linkbutton" iconCls="icon-ok" style="width:100%;height:32px;"> -->
<!-- 	        </div> -->
	    	<div id="ft_ins" style="text-align:right">
				<a href="javascript:boardsubmit()" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true">저장</a>
				<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cancel',plain:true">취소</a>
			</div>
    	</form>
        
    </div>
	<!--========================================= 글쓰기 화면 끝 =============================================  -->
	<div id = "dlg_edit" class="easyui-dialog" title="수정하기" data-options="closed:true" style="width: 700px; height: 'fit-content';">
	</div>
<!-- 	<div id = "dlg_pw" class="easyui-dialog" title="비밀번호 확인" data-options="closed:'true'"> -->
<!-- 		<form id="board_pw" method="post" action= "./boardUpdate.sp4" enctype = "multipart/form-data"> -->
<!-- 			<input id="modal_bm_no" name="bm_no" type="hidden"> -->
<!-- 			<input name="bm_pw" class="easyui-passwordbox" label = "비밀번호" labelPosition="top" required="required" prompt="Password" iconWidth="28" style="width:100%;"> -->
<!-- 		</form> -->
<!-- 	</div> -->
</body>
</html>