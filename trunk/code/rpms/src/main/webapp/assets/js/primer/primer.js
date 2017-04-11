/**
 * 引物管理
 *
 * @author Dendy
 * @since 2014-2-20 22:17:50
 */
$(function () {
    /**
     * 加载datagrid
     */
    var dataGrid = $('#primer-table').datagrid({
        title: "引物列表",
        fitColumns: true,
        checkOnSelect: true,
        selectOnCheck: true,
        nowrap: true,
        pagination: true,
        rownumbers: true,
        fit: true,
        pageSize : 20,
        url: getContentPath() + '/primer/pager.do',
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
                { field: 'updateUserName', title: '最后修改人', width: 60, align: 'center'},
                { field: 'updateTime', title: '修改时间', width: 80, align: 'center'},
                { field: 'remark', title: '备注', width: 100, align: 'center'}
            ]
        ],
        queryParams: {
            "no": $("#primer-no").val()
        },
        toolbar: '#primer-toolbar',
        onDblClickCell: function (rowIndex, field, value) {
            if (field != "id") {
                $("#primer-table").datagrid("unselectAll");
                $("#primer-table").datagrid("selectRow", rowIndex);
                var rowData = $("#primer-table").datagrid("getSelected");
                _primer_setEditForm(rowData);
            }
        },
        view: detailview,
        detailFormatter: function (index, row) {
            return "<div style='padding:2px'>" +
                "<div style=\"padding:5px;\" class=\"datagrid-toolbar\">" +
                "<table><tr>" +
                "<td><label>基因型：</label></td><td><input class=\"search-box codeA\" type=\"text\"/></td>" +
                "<td style='display: none;'><label>基因型B：</label></td><td style='display: none;'><input class=\"search-box codeB\" type=\"text\"/></td>" +
                "<td ><a href=\"javascript:void(0)\" class=\"easyui-linkbutton l-btn search\" iconcls=\"icon-search\"><span class=\"l-btn-left\"><span class=\"l-btn-text icon-search l-btn-icon-left\">查询</span></span></a></td>" +
                "</tr></table>" +
                "<a href=\"javascript:void(0);\" class=\"easyui-linkbutton l-btn l-btn-plain add\" iconcls=\"icon-add\" plain=\"true\" group=\"\"><span class=\"l-btn-left\"><span class=\"l-btn-text icon-add l-btn-icon-left\">添加</span></span></a>" +
                "<a href=\"javascript:void(0);\" class=\"easyui-linkbutton l-btn l-btn-plain edit\" iconcls=\"icon-edit\" plain=\"true\" group=\"\"><span class=\"l-btn-left\"><span class=\"l-btn-text icon-edit l-btn-icon-left\">编辑</span></span></a>" +
                "<a href=\"javascript:void(0);\" class=\"easyui-linkbutton l-btn l-btn-plain remove\" iconcls=\"icon-remove\" plain=\"true\" group=\"\"><span class=\"l-btn-left\"><span class=\"l-btn-text icon-remove l-btn-icon-left\">删除</span></span></a>" +
                "</div>" +
                "<table class='hm'></table>" +
                "</div>";
        },
        onExpandRow: function (index, row) {
            var genotypeInPrimer = $(this).datagrid('getRowDetail', index).find('table.hm');
            var toolBar = $(this).datagrid('getRowDetail', index).find('.datagrid-toolbar');
            var subGrid = genotypeInPrimer.datagrid({
                url: getContentPath() + '/gen/pager.do',
                fitColumns: true,
                singleSelect: false,
                checkOnSelect: true,
                selectOnCheck: true,
                nowrap: true,
                pagination: true,
                rownumbers: true,
                loadMsg: 'loading...',
                height: 'auto',
                toolbar: toolBar,
                queryParams: {
                    "primerNo": row.no,
                    "codeA": toolBar.find('.codeA').val(),
//                    "codeB": toolBar.find('.codeB').val()
                },
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
                        {field: 'codeA', title: '基因型', width: 100, align: 'center'},
//                        {field: 'codeB', title: '基因型B', width: 100, align: 'center'},
                        {field: 'createUserName', title: '创建人', width: 60, align: 'center'},
                        {field: 'createTime', title: '创建时间', width: 80, align: 'center'},
                        {field: 'updateUserName', title: '最后修改人', width: 60, align: 'center'},
                        {field: 'updateTime', title: '最后修改时间', width: 80, align: 'center'},
                        {field: 'remark', title: '备注', width: 100, align: 'center'}
                    ]
                ],
                onResize: function () {
                    $('#primer-table').datagrid('fixDetailRowHeight', index);
                },
                onLoadSuccess: function () {
                    setTimeout(function () {
                        $('#primer-table').datagrid('fixDetailRowHeight', index);
                    }, 0);
                },
                onDblClickCell: function (rowIndex, field, value) {
                    if (field != "id") {
                        $(subGrid).datagrid("unselectAll");
                        $(subGrid).datagrid("selectRow", rowIndex);
                        _genotype_setEditFormDialog(subGrid);
                    }
                }
            });
            $('#primer-table').datagrid('fixDetailRowHeight', index);

            // 注册事件，防止重复绑定
            toolBar.find('.add').unbind('click').bind('click', function () {
                _genotype_setAddForm(row, subGrid);
            });

            toolBar.find('.edit').unbind('click').bind('click', function () {
                _genotype_setEditForm(row, subGrid);
            });

            toolBar.find('.remove').unbind('click').bind('click', function () {
                var codeA = toolBar.find('.codeA').val();
                var codeB = toolBar.find('.codeB').val();
                _genotype_remove(codeA, codeB, row, subGrid);
            });
            toolBar.find('.search').unbind('click').bind('click', function () {
                var codeA = toolBar.find('.codeA').val();
                var codeB = toolBar.find('.codeB').val();
                _genotype_reloadDataGrid(codeA, codeB, row, subGrid);
            });

            /*toolBar.on('click', '.add', function () {
             _genotype_setAddForm(row, subGrid);
             });
             toolBar.on('click', '.edit', function () {
             _genotype_setEditForm(row, subGrid);
             });
             toolBar.on('click', '.remove', function () {
             var codeA = toolBar.find('.codeA').val();
             var codeB = toolBar.find('.codeB').val();
             _genotype_remove(codeA, codeB, row, subGrid);
             });
             toolBar.on('click', '.search', function () {
             var codeA = toolBar.find('.codeA').val();
             var codeB = toolBar.find('.codeB').val();
             _genotype_reloadDataGrid(codeA, codeB, row, subGrid);
             });*/
        }
    });

    /** *****************************点击事件和函数************************************** */
    function _genotype_setAddForm(rowData, openerGrid) {
        parent.$.modalDialog({
            title: '添加基因型',
            width: 350,
            height: 250,
            href: getContentPath() + '/primer/toAddGenPage.do?primerId=' + rowData.id,
            buttons: [
                {
                    text: '确定',
                    iconCls: 'icon-ok',
                    handler: function () {
                        parent.$.modalDialog.openner_dataGrid = openerGrid;
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
     * 修改引物信息
     *
     * @param rowData
     */
    function _primer_setEditForm(rowData) {
        parent.$.modalDialog({
            title: '修改引物信息',
            width: 350,
            height: 330,
            href: getContentPath() + '/primer/toUpdatePage.do',
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
     * 修改引物基因型信息
     *
     * @param rowData
     */
    function _genotype_setEditForm(rowData, openerGrid) {
        var rowDataArray = $(openerGrid).datagrid('getSelections');
        if (rowDataArray.length == 1) {
            _genotype_setEditFormDialog(openerGrid);
        } else if (rowDataArray.length > 1) {
            Dialog.warning('一次只能编辑一个基因型！', '警告');
        } else {
            Dialog.warning('请选择要编辑的基因型！', '警告');
        }
    }

    function _genotype_setEditFormDialog(openerGrid) {
        var genId = $(openerGrid).datagrid('getSelected').id;
        parent.$.modalDialog({
            title: '修改基因型信息',
            width: 350,
            height: 250,
            href: getContentPath() + '/primer/toUpdateGenPage.do?genId=' + genId,
            buttons: [
                {
                    text: '确定',
                    iconCls: 'icon-ok',
                    handler: function () {
                        parent.$.modalDialog.openner_dataGrid = openerGrid;
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

    function _genotype_remove(codeA, codeB, rowData, openerGrid) {
        var rows = $(openerGrid).datagrid('getChecked');
        var ids = $(rows).map(function (i, row) {
            return row.id;
        }).get().join(",");

        if (ids != '') {
            Dialog.confirm("该操作无法恢复，所选关联的信息将会被删除，请慎重，确定？", function () {
                $.ajax({
                    url: getContentPath() + "/gen/delete.do",
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
                            _genotype_reloadDataGrid(codeA, codeB, rowData, openerGrid);
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        Dialog.error("删除失败，请稍后重试！", "错误");
                    }
                });
            }, "确认");
        } else {
            Dialog.warning("请选择要删除的基因型！", "警告");
        }
    }

    function _genotype_reloadDataGrid(codeA, codeB, row, openerGrid) {
        $(openerGrid).datagrid("load", {
            "primerNo": row.no,
            "codeA": codeA,
            "codeB": codeB
        });
        $(openerGrid).datagrid("uncheckAll");
    }

    /**
     * 查询引物按钮点击事件
     */
    $("#primer-search").click(function () {
        _primer_reloadDataGrid();
    });

    function _primer_reloadDataGrid() {
        $('#primer-table').datagrid("load", {
            "no": $("#primer-no").val()
        });
        $('#primer-table').datagrid("uncheckAll");
    }

    /**
     * 添加引物
     */
    $("#primer-add").click(function () {
        parent.$.modalDialog({
            title: '添加引物信息',
            width: 350,
            height: 250,
            href: getContentPath() + '/primer/toAddPage.do',
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
     * 编辑引物
     */
    $("#primer-edit").click(function () {
        var rowDataArray = $('#primer-table').datagrid('getSelections');
        if (rowDataArray.length == 1) {
            _primer_setEditForm(rowDataArray[0]);
        } else if (rowDataArray.length > 1) {
            Dialog.warning('一次只能编辑一个引物信息！', '警告');
        } else {
            Dialog.warning('请选择要编辑的引物！', '警告');
        }
    });

    /**
     * 删除引物
     */
    $("#primer-delete").click(function () {
        var rows = $('#primer-table').datagrid('getChecked');
        var ids = $(rows).map(function (i, row) {
            return row.id;
        }).get().join(",");

        if (ids != '') {
            Dialog.confirm("该操作无法恢复，所选引物关联的信息将会被删除，请慎重，确定？", function () {
                $.ajax({
                    url: getContentPath() + "/primer/delete.do",
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
                            _primer_reloadDataGrid();
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        Dialog.error("删除失败，请稍后重试！", "错误");
                    }
                });
            }, "确认");
        } else {
            Dialog.warning("请选择要删除的引物！", "警告");
        }
    });
});