<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<form id="animal-transout-to-zoo" method="post" style="margin-top: 10px;">
    <table class="layout-table">
        <tr>
            <td style="text-align: right">动物芯片号：</td>
            <td><input type="text" readonly class="easyui-validatebox" style="width: 70%;" id="animal-chip-codes"></td>
        </tr>
        <tr>
            <td></td>
            <td>
                <span>当前被转移动物的芯片号</span>
            </td>
        </tr>
        <tr>
            <td style="text-align: right">当前所在圈舍：</td>
            <td><input readonly type="text" class="easyui-validatebox" style="width: 70%;"
                       id="animal-cur-house-number"></td>
        </tr>
        <tr>
            <td></td>
            <td>
                <span>当前被转移动物所在的圈舍编号(不显示在目标圈舍中)</span>
            </td>
        </tr>
        <tr>
            <td style="text-align: right;vertical-align: top;"><span style="color: red;">*</span>目标圈舍：</td>
            <td>
                <select id="animal-transout-house-table" required="true" name="houseByDestHouse.id"
                        style="width: 193px;"
                        class="easyui-combogrid"
                        data-options="
                    panelWidth: 500,
                    nowrap : true,
                    mode : 'remote',
                    pagination : true,
                    rownumbers : true,
                    fit : true,
                    idField: 'id',
                    editable : false,
                    textField: 'numer',
                    url: getContentPath() + '/house/pager.do',
                    method: 'post',
                    columns: [[{field : 'numer', title : '圈舍编号', width : 60, align: 'center'},
                        { field : 'name', title : '名称', width : 60, align: 'center'},
                        { field : 'location', title : '所在位置', width : 70, align: 'left'},
                        { field : 'zoo', title : '所在园区', width : 60, align: 'left'},
                        { field : 'cnt', title : '在养数量', width : 45, align: 'right'},
                        { field : 'info', title : '描述信息', width : 60, align: 'left'}
                        ]],
                    fitColumns: true,
                    toolbar : '#animal-transout-house-toolbar',
                    queryParams : {
                        'numer' : $('#animal-transout-house-search').searchbox('getValue'),
                        'excludesNumber' : getHouseNumber()
                    }">
                </select>

                <div id="animal-transout-house-toolbar" style="padding:5px;">
                    <input id="animal-transout-house-search" class="easyui-searchbox" style="width:70%;">
                </div>
            </td>
        </tr>
        <tr>
            <td></td>
            <td>
                <span>转到的圈舍<br><font color="red">注意：当前转移动物所在圈舍编号将不会显示</font></span>
            </td>
        </tr>
        <tr>
            <td style="text-align: right;vertical-align: top;">备注：</td>
            <td><textarea style="width: 70%;height: 70px;" name="remark" class="easyui-validatebox"></textarea></td>
        </tr>
    </table>
</form>
<script type="text/javascript">
    var houseNumbers;
    $(function () {
        var rows = $('#house-transfer-table').datagrid('getChecked');

        var microchipCodes = $(rows).map(function (i, row) {
            return row.microchipCode;
        }).get().join(",");

        var ids = $(rows).map(function (i, row) {
            if (row.status == RED_PANDA.STATUS_FEEDING)
                return row.id;
        }).get().join(",");

        houseNumbers = $(rows).map(function (i, row) {
            return row.houseNumber;
        }).get().join(",");

        $('#animal-chip-codes').val(microchipCodes);
        $('#animal-cur-house-number').val(houseNumbers);

        $('#animal-transout-house-search').searchbox({
            prompt: '输入编号查询',
            searcher: function () {
                _animal_transout_house_do_search();
            }
        });

        $('#animal-transout-house-search').keyup(function (e) {
            _animal_transout_house_do_search();
        });

        function _animal_transout_house_do_search() {
            $('#animal-transout-house-table').combogrid('grid').datagrid("load", {
                "numer": $("#animal-transout-house-search").searchbox('getValue'),
                'excludesNumber' : getHouseNumber()
            });
        }

        parent.$.messager.progress('close');
        $('#animal-transout-to-zoo').form({
            url: getContentPath() + '/ht/transOutToHouse.do',
            onSubmit: function (params) {
                params.ids = ids;
                return $(this).form('validate');
            },
            success: function (result) {
                result = $.parseJSON(result);
                if (result.type == 'success') {
                    parent.$.modalDialog.handler.dialog('close');
//                    Dialog.info(result.msg, '提示', function () {
                    parent.$.modalDialog.openner_dataGrid.datagrid('reload');
//                    });
                } else {
                    Dialog.error(result.msg, '错误');
                }
            }
        });
    });

    function getHouseNumber() {
        return houseNumbers;
    }
</script>