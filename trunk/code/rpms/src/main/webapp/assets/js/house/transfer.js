/**
 * 圈舍转移管理
 *
 * @author Dendy
 * @since 2014-8-29 16:41:37
 */

$(function () {
    /**
     * 加载datagrid
     */
    var dataGrid = $('#house-transfer-table').datagrid({
        title: "动物列表",
        fitColumns: true,
        checkOnSelect: true,
        selectOnCheck: true,
        nowrap: true,
        pagination: true,
        rownumbers: true,
        fit: true,
        pageSize : 20,
        url: getContentPath() + '/rp/pager.do',
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
                {field: 'typeName', title: '物种', width: 50, align: 'center'},
                {field: 'tatooCode', title: '编号', width: 50, align: 'center'},
                {field: 'microchipCode', title: '芯片号', width: 130, align: 'center'},
                {field: 'houseNumber', title: '当前圈舍编号', width: 70, align: 'center'},
                { field: 'studbookCode', title: '谱系号', width: 70, align: 'center'},
                { field: 'name', title: '呼名', width: 70, align: 'center'},
                { field: 'sex', title: '性别', width: 40, align: 'center', formatter: function (value, row, index) {
                    if (value == SEX.FEMALE)
                        return "雌性";
                    else if (value == SEX.MALE)
                        return "雄性";
                }},
                { field: 'age', title: '年龄', width: 40, align: 'center'},
                { field: 'status', title: '状态', width: 40, align: 'center', formatter: function (value, row, index) {
                    if (value == RED_PANDA.STATUS_TRANS_OUT)
                        return "<span style='color: red;'>转出</span>";
                    else if (value == RED_PANDA.STATUS_FEEDING)
                        return "<span style='color: green;'>在养</span>";
                }},
                { field: 'birthDate', title: '出生日期', width: 100, align: 'center'},
                { field: 'chipTime', title: '芯片植入日期', width: 100, align: 'center'},
                { field: 'fatherChipCode', title: '父亲芯片号', width: 70, align: 'center'},
                { field: 'motherChipCode', title: '母亲芯片号', width: 70, align: 'center'}
            ]
        ],
        queryParams: {
            "microchipCode": $("#house-transfer-no").val(),
            "name": $("#house-transfer-name").val(),
            "houseId": $("#house-transfer-house-id").val(),
            "status" : RED_PANDA.STATUS_FEEDING,
            "no" : $("#house-transfer-tatoono").val()
//            "orderField": "house,type.id",
//            "orderType": "desc,desc"
        },
        toolbar: '#house-transfer-toolbar',
        onDblClickCell: function (rowIndex, field, value) {
            if (field != "id") {
                $("#house-transfer-table").datagrid("unselectAll");
                $("#house-transfer-table").datagrid("selectRow", rowIndex);
                var rowData = $("#house-transfer-table").datagrid("getSelected");
                _animal_transfer_records(rowData);
            }
        }
    });

    /** *****************************点击事件和函数************************************** */
    /**
     * 查询按钮点击事件
     */
    $("#house-transfer-search").click(function () {
        _house_transfer_reloadDataGrid();
    });

    function _house_transfer_reloadDataGrid() {
        $('#house-transfer-table').datagrid("load", {
            "microchipCode": $("#house-transfer-no").val(),
            "name": $("#house-transfer-name").val(),
            "houseId": $("#house-transfer-house-id").val(),
            "no" : $("#house-transfer-tatoono").val()
//            "orderField": "house,type.id",
//            "orderType": "desc,desc"
        });
        $('#house-transfer-table').datagrid("uncheckAll");
    }

    /**
     * 转出到其他园区按钮点击事件
     */
    $("#house-transfer-transout-to-other-zoo").unbind('click').bind('click', (function () {
        var rows = $('#house-transfer-table').datagrid('getChecked');
        var ids = $(rows).map(function (i, row) {
            if (row.status == RED_PANDA.STATUS_FEEDING)
                return row.id;
        }).get().join(",");

        if (ids != '') {
//            Dialog.confirm("您确定要将所选动物转移到其他园区？非在养动物将被忽略.", function () {
            parent.$.modalDialog({
                title: '转出到其他园区',
                width: 450,
                height: 350,
                href: getContentPath() + '/ht/toOutOtherZoo.do',
                buttons: [
                    {
                        text: '确定',
                        iconCls: 'icon-ok',
                        handler: function () {
                            parent.$.modalDialog.openner_dataGrid = dataGrid;
                            var f = parent.$.modalDialog.handler.find('form');
                            f.submit();
                        }
                    },
                    {
                        text: '取消',
                        iconCls: 'icon-cancel',
                        handler: function () {
                            parent.$.modalDialog.handler.dialog('close');
                        }
                    }
                ]
            });
//            }, "确认");
        } else {
            Dialog.warning("请选择要转出的在养动物！", "警告");
        }
    }));

    /**
     * 转出到本园区圈舍按钮点击事件
     */
    $("#house-transfer-trans-out-to-house").unbind('click').bind('click', (function () {
        var rows = $('#house-transfer-table').datagrid('getChecked');

        var ids = $(rows).map(function (i, row) {
            if (row.status == RED_PANDA.STATUS_FEEDING)
                return row.id;
        }).get().join(",");

        if (ids != '') {
//            Dialog.confirm("您确定要将所选动物转移到本园区其他圈舍中？非在养动物将被忽略.", function () {
            parent.$.modalDialog({
                title: '转出到其他圈舍',
                width: 450,
                height: 400,
                href: getContentPath() + '/ht/toOutOtherHouse.do',
                buttons: [
                    {
                        text: '确定',
                        iconCls: 'icon-ok',
                        handler: function () {
                            parent.$.modalDialog.openner_dataGrid = dataGrid;
                            var f = parent.$.modalDialog.handler.find('form');
                            f.submit();
                        }
                    },
                    {
                        text: '取消',
                        iconCls: 'icon-cancel',
                        handler: function () {
                            parent.$.modalDialog.handler.dialog('close');
                        }
                    }
                ]
            });
//            }, "确认");
        } else {
            Dialog.warning("请选择要转出的在养动物！", "警告");
        }
    }));

    /**
     * 转移历史
     */
    $("#house-transfer-trans-record").unbind('click').bind('click', (function () {
        var rowDataArray = $('#house-transfer-table').datagrid('getSelections');
        if (rowDataArray.length == 1) {
            _animal_transfer_records(rowDataArray[0]);
        } else if (rowDataArray.length > 1) {
            Dialog.warning('一次只能查看一只动物的转移历史记录！', '警告');
        } else {
            Dialog.warning('请选择一只动物！', '警告');
        }
    }));

    /**
     * 转移记录信息
     *
     * @param rowData
     */
    function _animal_transfer_records(rowData) {
        parent.$.modalDialog({
            title: '动物转移历史记录',
            width: 800,
            height: 480,
            href: getContentPath() + '/ht/toTransRecords.do',
            buttons: [
                {
                    text: '关闭',
                    iconCls: 'icon-cancel',
                    handler: function () {
                        parent.$.modalDialog.handler.dialog('close');
                    }
                }
            ]
        });
    }
});