<#-- 自定义的分页指令。
属性说明：
   pageNo      当前页号(int类型)
   pageSize    每页要显示的记录数(int类型)
   toURL       点击分页标签时要跳转到的目标URL(string类型)
   recordCount 总记录数(int类型)
 使用方式：
  <#if recordCount??>
    <#import "/pager.ftl" as q>
    <@q.pager pageNo=pageNo pageSize=pageSize recordCount=recordCount toURL="testpager.do"/>
  </#if>
 -->
<#-- 版权归qiujy所有，转载请注明。qjyong@gmail.com -->

<#macro pager pageNo pageSize toURL recordCount>  
  <#-- 定义局部变量pageCount保存总页数 -->
  <#assign pageCount=((recordCount + pageSize - 1) / pageSize)?int>  
	<#if recordCount==0><#return/></#if>
<#-- 输出分页样式 -->
<style type="text/css">
.pagination {padding: 5px;float:right;font-size:12px;}
.pagination a, .pagination a:link, .pagination a:visited {padding:2px 5px;margin:2px;border:1px solid #aaaadd;text-decoration:none;color:#006699;}
.pagination a:hover, .pagination a:active {border: 1px solid #ff0000;color: #000;text-decoration: none;}
.pagination span.current {padding: 2px 5px;margin: 2px;border: 1px solid #ff0000;font-weight: bold;background-color: #ff0000;color: #FFF;}
.pagination span.disabled {padding: 2px 5px;margin: 2px;border: 1px solid #eee; color: #ddd;}
</style>
<#-- 页号越界处理 -->
  <#if (pageNo > pageCount)>
    <#assign pageNo=pageCount>
  </#if>
  <#if (pageNo < 1)>
    <#assign pageNo=1>
  </#if>
<#-- 输出分页表单 -->
<div class="pagination">
<form method="post" action="" name="qqPagerForm">
<#-- 把请求中的所有参数当作隐藏表单域(无法解决一个参数对应多个值的情况) -->
<#list RequestParameters?keys as key>
<#if (key!="pageNo" && RequestParameters[key]??)>
<input type="hidden" name="${key}" value="${RequestParameters[key]}"/>
</#if>
</#list>
<input type="hidden" name="pageNo" value="${pageNo}"/>
<#-- 上一页处理 -->
  <#if (pageNo == 1)>
      <span class="disabled">&laquo;&nbsp;首页</span>
      <span class="disabled">&laquo;&nbsp;上一页</span>
  <#else>
      <a href="javascript:void(0)" onclick="turnOverPage(1)">&laquo;&nbsp;首页</a>
      <a href="javascript:void(0)" onclick="turnOverPage(${pageNo - 1})">&laquo;&nbsp;上一页</a>
  </#if>
    <#if (1>pageNo-pageSize/2)>
        <#assign start=1>
    <#else>
        <#assign start=pageNo-pageSize/2>
    </#if>

    <#if (start+pageSize-1>pageCount)>
        <#assign end=pageCount>
    <#else>
        <#assign end=start+pageSize-1>
    </#if>

  <#list start..end as i>
    <#if (pageNo==i)>
        <span class="current">${i}</span>
		<#else>
            <a href="javascript:void(0)" onclick="turnOverPage(${i})">${i}</a>
    </#if>
  </#list>
<#-- 下一页处理 -->
  <#if (pageNo == pageCount)>
      <span class="disabled">下一页&nbsp;&raquo;</span>
      <span class="disabled">尾页&nbsp;&raquo;</span>
  <#else>
        <a href="javascript:void(0)" onclick="turnOverPage(${pageNo + 1})">下一页&nbsp;&raquo;</a>
        <a href="javascript:void(0)" onclick="turnOverPage(${pageCount})">尾页&nbsp;&raquo;</a>
  </#if>
</form>
<script language="javascript">
  function turnOverPage(no){
    var qForm=document.qqPagerForm;
    if(no>${pageCount}){no=${pageCount};}
    if(no<1){no=1;}
    qForm.pageNo.value=no;
    qForm.action="${toURL}";
    qForm.submit();
  }
</script>
</div> 
</#macro>  