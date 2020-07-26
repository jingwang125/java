<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/views/include/header.jsp"%>

<link rel="stylesheet" href="/kitchen/kendo/styles/kendo.common.min.css">
<link rel="stylesheet"
	href="/kitchen/kendo/styles/kendo.default.min.css">
<link rel="stylesheet"
	href="/kitchen/kendo/styles/kendo.default.mobile.min.css">
<script src="/kitchen/kendo/js/kendo.all.min.js"></script>
<script src="/kitchen/kendo/js/jquery.min.js"></script>

<html>
<title>:: 업로드 파일 썸네일 생성 ::</title>
<head>
<title></title>
<style>
.file-icon {
	display: inline-block;
	float: left;
	width: 48px;
	height: 48px;
	margin-left: 10px;
	margin-top: 13.5px;
}

.img-file {
	background-image: url(../content/web/upload/jpg.png)
}

.doc-file {
	background-image: url(../content/web/upload/doc.png)
}

.pdf-file {
	background-image: url(../content/web/upload/pdf.png)
}

.xls-file {
	background-image: url(../content/web/upload/xls.png)
}

.zip-file {
	background-image: url(../content/web/upload/zip.png)
}

.default-file {
	background-image: url(../content/web/upload/default.png)
}

#example .file-heading {
	font-family: Arial;
	font-size: 1.1em;
	display: inline-block;
	float: left;
	width: 60%;
	margin: 0 0 0 20px;
	height: 25px;
	-ms-text-overflow: ellipsis;
	-o-text-overflow: ellipsis;
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
}

#example .file-name-heading {
	font-weight: bold;
	margin-top: 20px;
}

#example .file-size-heading {
	font-weight: normal;
	font-style: italic;
}

li.k-file div.file-wrapper {
	position: relative;
	height: 75px;
	width: 100%;
}
</style>
</head>
<body>
	<div id="example">
		<div class="demo-section k-content">
			<input type="file" name="files" id="files" />
		</div>
	</div>
</body>
</html>
<script id="fileTemplate" type="text/x-kendo-template">
<span class='k-progress'></span>
                <div class='file-wrapper'>
                    <span class='file-icon #=addExtensionClass(files[0].extension)#'></span>
                    <h4 class='file-heading file-name-heading'>Name: #=name#</h4>
                    <h4 class='file-heading file-size-heading'>Size: #=size# bytes</h4>
                    <strong class="k-upload-status">
                        <button type='button' class='k-upload-action'></button>
                        <button type='button' class='k-upload-action'></button>
                    </strong>
                </div>
</script>

<script>
	$(document).ready(function() {
		$("#files").kendoUpload({
			multiple : true,
			async : {
				saveUrl : "save",
				removeUrl : "remove",
				autoUpload : false
			},
			template : kendo.template($('#fileTemplate').html())
		});
	});

	function addExtensionClass(extension) {
		switch (extension) {
		case '.jpg':
		case '.img':
		case '.png':
		case '.gif':
			return "img-file";
		case '.doc':
		case '.docx':
			return "doc-file";
		case '.xls':
		case '.xlsx':
			return "xls-file";
		case '.pdf':
			return "pdf-file";
		case '.zip':
		case '.rar':
			return "zip-file";
		default:
			return "default-file";
		}
	}
</script>

