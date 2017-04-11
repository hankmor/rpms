/**
 * 圈舍管理
 *
 * @author Dendy
 * @since 2014-2-20 22:17:50
 */
$(function () {
    /**
     * 加载datagrid
     */
    var dataGrid = $('#house-table').datagrid({
        title: "圈舍列表",
        fitColumns: true,
        checkOnSelect: true,
        selectOnCheck: true,
        nowrap: true,
        pagination: true,
        rownumbers: true,
        fit: true,
        pageSize : 20,
        url: getContentPath() + '/house/pager.do',
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
                {field: 'numer', title: '圈舍编号', width: 70, align: 'center'},
                { field: 'name', title: '名称', width: 70, align: 'center'},
                { field: 'location', title: '所在位置', width: 90, align: 'left'},
                { field: 'cnt', title: '在养数量', width: 40, align: 'center'},
                { field: 'description', title: '描述信息', width: 100, align: 'left'},
                { field: 'createUserName', title: '创建人', width: 60, align: 'center'},
                { field: 'createTime', title: '创建时间', width: 80, align: 'center'},
                { field: 'remark', title: '备注', width: 100, align: 'center'}
            ]
        ],
        queryParams: {
            "numer": $("#house-no").val(),
            "name": $("#house-name").val(),
            "location": $("#house-location").val()
        },
        toolbar: '#house-toolbar',
        onDblClickCell: function (rowIndex, field, value) {
            if (field != "id") {
                $("#house-table").datagrid("unselectAll");
                $("#house-table").datagrid("selectRow", rowIndex);
                var rowData = $("#house-table").datagrid("getSelected");
                _house_setEditForm(rowData);
            }
        },
        view: detailview,
        detailFormatter: function (index, row) {
            return '<div style="padding:2px"><table class="hm"></table></div>';
        },
        onExpandRow: function (index, row) {
            var hm = $(this).datagrid('getRowDetail', index).find('table.hm');
            hm.datagrid({
                url: getContentPath() + '/rp/pager.do',
                fitColumns: true,
                singleSelect: true,
                checkOnSelect: false,
                selectOnCheck: false,
                nowrap: true,
                pagination: false,
                rownumbers: true,
                loadMsg: 'loading...',
                height: 'auto',
                queryParams: {
                    "houseId": row.id
                },
                columns: [
                    [
                        {field: 'typeName', title: '物种', width: 50, align: 'center'},
                        {field: 'microchipCode', title: '芯片号', width: 70, align: 'center'},
                        { field: 'studbookCode', title: '谱系号', width: 70, align: 'center'},
                        { field: 'name', title: '呼名', width: 70, align: 'center'},
                        { field: 'sex', title: '性别', width: 40, align: 'center', formatter: function (value, row, index) {
                            if (value == SEX.FEMALE)
                                return "雌性";
                            else if (value == SEX.MALE)
                                return "雄性";
                        }},
                        { field: 'age', title: '年龄', width: 40, align: 'center'},
                        { field: 'birthDate', title: '出生日期', width: 100, align: 'center'},
                        { field: 'chipTime', title: '芯片植入日期', width: 100, align: 'center'},
                        { field: 'houseNumber', title: '所在圈舍编号', width: 70, align: 'center'},
                        { field: 'fatherChipCode', title: '父亲芯片号', width: 70, align: 'center'},
                        { field: 'motherChipCode', title: '母亲芯片号', width: 70, align: 'center'},
                        { field: 'status', title: '状态', width: 40, align: 'center', formatter: function (value, row, index) {
                            if (value == RED_PANDA.STATUS_TRANS_OUT)
                                return "<span style='color: red;'>转出</span>";
                            else if (value == RED_PANDA.STATUS_FEEDING)
                                return "<span style='color: green;'>在养</span>";
                            else if (value == RED_PANDA.STATUS_DEAD)
                                return "<span style='color: darkgray;'>死亡</span>";
                        }}
                    ]
                ],
                onResize: function () {
                    $('#house-table').datagrid('fixDetailRowHeight', index);
                },
                onLoadSuccess: function () {
                    setTimeout(function () {
                        $('#house-table').datagrid('fixDetailRowHeight', index);
                    }, 0);
                }
            });
            $('#house-table').datagrid('fixDetailRowHeight', index);
        }
    });

    /** *****************************点击事件和函数************************************** */
    /**
     * 修改用户信息
     *
     * @param rowData
     */
    function _house_setEditForm(rowData) {
        parent.$.modalDialog({
            title: '修改圈舍信息',
            width: 350,
            height: 330,
            href: getContentPath() + '/house/toUpdatePage.do',
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
    }

    /**
     * 查询按钮点击事件
     */
    $("#house-search").click(function () {
        _house_reloadDataGrid();
    });

    function _house_reloadDataGrid() {
        $('#house-table').datagrid("load", {
            "numer": $("#house-no").val(),
            "name": $("#house-name").val(),
            "location": $("#house-location").val()
        });
        $('#house-table').datagrid("uncheckAll");
    }

    /**
     * 添加按钮点击事件
     */
    $("#house-add").click(function () {
        parent.$.modalDialog({
            title: '添加圈舍',
            width: 350,
            height: 330,
            href: getContentPath() + '/house/toAddPage.do',
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
    });

    /**
     * 编辑按钮点击事件
     */
    $("#house-edit").click(function () {
        var rowDataArray = $('#house-table').datagrid('getSelections');
        if (rowDataArray.length == 1) {
            _house_setEditForm(rowDataArray[0]);
        } else if (rowDataArray.length > 1) {
            Dialog.warning('一次只能编辑一个圈舍信息！', '警告');
        } else {
            Dialog.warning('请选择要编辑的圈舍！', '警告');
        }
    });

    /**
     * 删除按钮点击事件
     */
    $("#house-delete").click(function () {
        var rows = $('#house-table').datagrid('getChecked');
        var ids = $(rows).map(function (i, row) {
            return row.id;
        }).get().join(",");

        if (ids != '') {
            Dialog.confirm("该操作无法恢复，所选圈舍关联的信息将会被删除，请慎重，确定？", function () {
                $.ajax({
                    url: getContentPath() + "/house/delete.do",
                    type: "post",
                    dataType: "json",
                    data: {
                        "ids": ids
                    },
                    beforeSend: function (jqXHR, settings) {
                        Dialog.fullprogress.open('删除中，请稍候...', "操作");
                    },
                    complete: function (jqXHR, textStatus) {
                        Dialog.fullprogress.close();
                    },
                    success: function (data, textStatus, jqXHR) {
                        if (data.type == "error") {
                            Dialog.error(data.msg, "错误");
                        } else {
                            _house_reloadDataGrid();
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        Dialog.error("删除失败，请稍后重试！", "错误");
                    }
                });
            }, "确认");
        } else {
            Dialog.warning("请选择要删除的圈舍！", "警告");
        }
    });
});