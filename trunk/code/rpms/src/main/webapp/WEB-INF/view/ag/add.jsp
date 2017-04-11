<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<form id="animal-genotype-add-form" method="post" style="margin-top: 10px;">
    <input type="hidden" name="id" id="add-genotype-primer-id-genotype" value="${animal.id}">
    <table class="layout-table">
        <tr>
            <td style="text-align: right"><span style="color: red;">*</span>引物编号：</td>
            <td>
                <select id="animal-primer-add-table" required="true" name="primerNo" style="width: 153"
                        class="easyui-combogrid"
                        data-options="panelWidth: 600,
                    nowrap : true,
                    pagination : true,
                    rownumbers : true,
                    fit : true,
                    mode : 'remote',
                    editable : false,
                    idField: 'no',
                    textField: 'no',
                    url: getContentPath() + '/primer/pager.do',
                    method: 'post',
                    frozenColumns: [
                        [
                            {
                                field: 'id',
                                align: 'center',
                                checkbox: true
                            }
                        ]
                    ],
                    columns: [
                        [
                            {field: 'no', title: '引物编号', width: 70, align: 'center'},
                            { field: 'genotypeCnt', title: '基因型数量', width: 40, align: 'center'},
                            { field: 'createUserName', title: '创建人', width: 60, align: 'center'},
                            { field: 'createTime', title: '创建时间', width: 80, align: 'center'},
                            <%--{ field: 'updateUserName', title: '最后修改人', width: 60, align: 'center'},--%>
                            <%--{ field: 'updateTime', title: '修改时间', width: 80, align: 'center'},--%>
                            { field: 'remark', title: '备注', width: 100, align: 'center'}
                        ]
                    ],
                    fitColumns: true,
                    queryParams: {
                        'no': $('#animal-primer-add-search').searchbox('getValue'),
                    },
                    toolbar: '#animal-primer-add-toolbar',
                    <%--onCheck : function (index, row) {
                        var _url = getContentPath() + '/gen/list.do';
                        var _primerNo = row.no;
                        $.ajax({
                            url : _url,
                            dataType : 'json',
                            type : 'post',
                            data : {
                                'primerNo' : _primerNo
                            },
                            success : function (data){
                                _codes.length = 0;
                                var _codeInit = [];
                                for (var d in data) {
                                    _codes.push(data[d].codeA);
                                    _codeInit.push({'codeA' : data[d].codeA});
                                };
                                $('#codeA').combobox('setValue', '').combobox('loadData', _codeInit);
                                $('#codeB').combobox('setValue', '').combobox('loadData', _codeInit);
                            }
                        });
                    }--%>
                    onChange : function (nv, ov) {
                        var url = getContentPath() + '/gen/list.do?primerNo=' + nv;
                        $('#codeA').combobox('reload', url);
                        $('#codeB').combobox('reload', url);
                    }">
                </select>

                <div id="animal-primer-add-toolbar" style="padding:5px;">
                    <input id="animal-primer-add-search" class="easyui-searchbox" style="width:120px">
                </div>
            </td>
        </tr>
        <tr>
            <td style="text-align: right">基因型A：</td>
            <td><input class="easyui-combobox" data-options="valueField:'codeA',textField:'codeA'" name="codeA" id="codeA" type="text" validType="digit"></td>
        </tr>
        <tr>
            <td style="text-align: right">基因型B：</td>
            <td><input class="easyui-combobox" data-options="valueField:'codeA',textField:'codeA'" name="codeB" id="codeB" type="text" validType="digit"></td>
        </tr>
    </table>
</form>
<script type="text/javascript">
    var _codes = [];
    $(function () {
        function _animal_primer_add_search() {
            $('#animal-primer-add-table').combogrid('grid').datagrid("load", {
                'no': $('#animal-primer-add-search').searchbox('getValue')
            });
        }

        $('#animal-primer-add-search').searchbox({
            prompt: '输入引物编号查询',
            searcher: function () {
                _animal_primer_add_search();
            }
        });
        parent.$.messager.progress('close');

        $('#animal-genotype-add-form').form({
            url: getContentPath() + '/rp/addGens.do',
            onSubmit: function () {
                return $(this).form('validate');
            },
            success: function (result) {
                result = $.parseJSON(result);
                if (result.type == 'success') {
                    parent.$.modalDialog.handler.dialog('close');
                    //Dialog.info(result.msg,'提示',function(){
                    parent.$.modalDialog.openner_dataGrid.datagrid('reload');
                    //});
                } else {
                    Dialog.error(result.msg, '错误');
                }
            }
        });

//        $('#codeA').combobox({
//            valueField: 'codeA',
//            textField: 'codeA',
//            onChange: function (newValue, oldValue) {
//                var _data =  _queryFromCodes(newValue);
//                $('#codeA').combobox('loadData', _data);
//                // 影响性能 2014-11-16 10:53:24 sun
////                if (newValue != null) {
////                    var primerNo = $('#animal-primer-add-table').combogrid('getText');
////                    var url = getContentPath() + '/gen/list.do?code=' + newValue;
////                    if (primerNo)
////                        url += '&primerNo=' + primerNo;
////                    $("#codeA").combobox("reload", url);
////                }
//            }
//        });

//        $('#codeB').combobox({
//            valueField: 'codeA',
//            textField: 'codeA',
//            onChange: function (newValue, oldValue) {
//                var _data =  _queryFromCodes(newValue);
//                $('#codeB').combobox('loadData', _data);
//                // 影响性能 2014-11-16 10:53:21 sun
////                if (newValue != null) {
////                    var primerNo = $('#animal-primer-add-table').combogrid('getText');
////                    var url = getContentPath() + '/gen/list.do?code=' + newValue;
////                    if (primerNo)
////                        url += '&primerNo=' + primerNo;
////                    $("#codeB").combobox("reload", url);
////                }
//            }
//        });

//        function _queryFromCodes (key) {
//            var _d = [];
//            for (var i in _codes) {
//                var _codeA = _codes[i] + "";
//                if ((_codeA + "").startWith(key)) {
//                    _d.push({"codeA" : _codeA});
//                }
//            }
//            return _d;
//        }
    });
</script>