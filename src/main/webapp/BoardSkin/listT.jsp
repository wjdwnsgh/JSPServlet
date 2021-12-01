<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./commons/header.jsp" %>
<body>
<div class="container">
    <!-- Top영역 -->
    <%@ include file="./commons/top.jsp" %>
    <!-- Body영역 -->
    <div class="row">
        <!-- Left메뉴영역 -->
        <%@ include file="./commons/left.jsp" %>
        <!-- Contents영역 -->
        <div class="col-9 pt-3">
            <h3>게시판 목록 - <small>자유게시판</small></h3>
            <!-- 검색 -->
            <div class="row">
                <form action="">
                    <div class="input-group ms-auto" style="width: 400px;">
                        <select name="" class="form-control">
                            <option value="">제목</option>
                            <option value="">내용</option>
                            <option value="">작성자</option>
                        </select>
                        <input type="text" class="form-control" placeholder="Search" style="width: 200px;">
                        <button class="btn btn-success" type="submit">
                            <i class="bi-search" style="font-size: 1rem; color: white;"></i>
                        </button>
                    </div>
                </form>
            </div>
            <!-- 게시판 리스트 -->
            <div class="row mt-3 mx-1">
                <table class="table table-bordered table-hover table-striped">
                <thead>
                    <tr class="text-center">
                        <th>번호</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>작성일</th>
                        <th>조회수</th>
                        <th>첨부</th>
                    </tr>
                </thead>
                <tbody>

                    <tr class="text-center">
                        <td>100</td>
                        <td class="text-start"><a href="./viewT.jsp">자유게시판 많은 이용 부탁드려요</a></td>
                        <td>낙자쌤</td>
                        <td>21-11-25</td>
                        <td>88</td>
                        <td><i class="bi-pin-angle-fill" style="font-size: 1rem;"></i></td>
                    </tr>
                    <tr class="text-center">
                        <td>100</td>
                        <td class="text-start"><a href="./viewT.jsp">자유게시판 많은 이용 부탁드려요</a></td>
                        <td>낙자쌤</td>
                        <td>21-11-25</td>
                        <td>88</td>
                        <td><i class="bi-pin-angle-fill" style="font-size: 1rem;"></i></td>
                    </tr>
                    <tr class="text-center">
                        <td>100</td>
                        <td class="text-start"><a href="./viewT.jsp">자유게시판 많은 이용 부탁드려요</a></td>
                        <td>낙자쌤</td>
                        <td>21-11-25</td>
                        <td>88</td>
                        <td><i class="bi-pin-angle-fill" style="font-size: 1rem;"></i></td>
                    </tr>
                    <tr class="text-center">
                        <td>100</td>
                        <td class="text-start"><a href="./viewT.jsp">자유게시판 많은 이용 부탁드려요</a></td>
                        <td>낙자쌤</td>
                        <td>21-11-25</td>
                        <td>88</td>
                        <td><i class="bi-pin-angle-fill" style="font-size: 1rem;"></i></td>
                    </tr>                    
                    
                </tbody>
                </table>
            </div>
            <!-- 각종버튼 -->
            <div class="row">
                <div class="col d-flex justify-content-end">
                    <button type="button" class="btn btn-primary" onclick="location.href='writeT.jsp';">글쓰기</button>
                    <button type="button" class="btn btn-secondary">수정하기</button>
                    <button type="button" class="btn btn-success">삭제하기</button>
                    <button type="button" class="btn btn-info">답글쓰기</button>
                    <button type="button" class="btn btn-warning">목록보기</button>
                    <button type="button" class="btn btn-danger">전송하기</button>
                    <button type="button" class="btn btn-dark">다시쓰기</button>
                </div>
            </div>
            <!-- 페이지 번호 -->
            <div class="row mt-3">
                <div class="col">
                    <ul class="pagination justify-content-center">
                        <li class="page-item"><a class="page-link" href="#">
                            <i class='bi bi-skip-backward-fill'></i>
                        </a></li>
                        <li class="page-item"><a class="page-link" href="#">
                            <i class='bi bi-skip-start-fill'></i>
                        </a></li>
                        <li class="page-item active"><a class="page-link" href="#">1</a></li>
                        <li class="page-item"><a class="page-link" href="#">2</a></li>
                        <li class="page-item"><a class="page-link" href="#">3</a></li>
                        <li class="page-item"><a class="page-link" href="#">
                            <i class='bi bi-skip-end-fill'></i>
                        </a></li>
                        <li class="page-item"><a class="page-link" href="#">
                            <i class='bi bi-skip-forward-fill'></i>
                        </a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <!-- Copyright영역 -->
    <%@ include file="./commons/copyright.jsp" %>
</div>
</body>
</html>