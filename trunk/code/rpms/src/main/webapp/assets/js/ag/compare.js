/**
 * 动物管理
 *
 * @author Dendy
 * @since 2014-2-20 22:17:50
 */
$(function () {
    var frozenCols = [
        [
            {field: 'tatooCode', rowspan: 2, title: '编号', width: 40, align: 'center'},
            {field: 'microchipCode', rowspan: 2, title: '芯片号', width: 130, align: 'center'}
        ]
    ];

//    var exists = $('#index_tabs').tabs('exists', '动物基因型对比');
//    if (!exists) {
        $.ajax({
            url: getContentPath() + "/ag/cp/primers.do",
            dataType: 'json',
            type: 'post',
            data: {
                'animalIds': $('#animal-ids').val(),
                'primerIds': null
            },
            success: function (data) {
                var cols = [
                    [],
                    []
                ];
                for (var i = 0; i < data.length; i++) {
                    var primerTitle = {field: '', title: data[i].no, colspan: 2, width: 100, align: 'center'};
                    var genotypeCodeA = {field: 'codeA' + i, title: 'A', width: 50, align: 'center'};
                    var genotypeCodeB = {field: 'codeB' + i, title: 'B', width: 50, align: 'center'};
                    cols[0].push(primerTitle);
                    cols[1].push(genotypeCodeA);
                    cols[1].push(genotypeCodeB);
                }
                // 初始化表格
                var dataGrid = $('#genotype-animal-compare-table').datagrid({
                    title: "基因型对照表",
                    fitColumns: false,
                    checkOnSelect: true,
                    selectOnCheck: true,
                    nowrap: true,
                    pagination: false,
                    rownumbers: true,
                    fit: false,
                    frozenColumns: frozenCols,
                    columns: cols
                });
                _loadData($('#animal-ids').val(), null, data);
            },
            error: function () {
                Dialog.error('系统异常，请联系系统管理员', '错误');
            }
        });
//    }

    /**
     * 动态加载表格
     */
    $('#genotype-animal-compare-search').click(function () {
        var primerIds = $('#primerIds-table').combogrid('getValues');
        var ids = $(primerIds).map(function (i, id) {
            return id;
        }).get().join(",");
        $.ajax({
            url: getContentPath() + '/ag/cp/primers.do',
            dataType: 'json',
            type: 'post',
            data: {
                animalIds: null,
                primerIds: ids
            },
            success: function (data) {
                var cols = [
                    [],
                    []
                ];
                for (var i = 0; i < data.length; i++) {
                    var primerTitle = {field: '', title: data[i].no, colspan: 2, width: 100, align: 'center'};
                    var genotypeCodeA = {field: 'codeA' + i, title: 'A', width: 50, align: 'center'};
                    var genotypeCodeB = {field: 'codeB' + i, title: 'B', width: 50, align: 'center'};
                    cols[0].push(primerTitle);
                    cols[1].push(genotypeCodeA);
                    cols[1].push(genotypeCodeB);
                }
                // 初始化表格
                var dataGrid = $('#genotype-animal-compare-table').datagrid({
                    title: "基因型对照表",
                    fitColumns: false,
                    checkOnSelect: true,
                    selectOnCheck: true,
                    nowrap: true,
                    pagination: false,
                    rownumbers: true,
                    fit: false,
                    frozenColumns: frozenCols,
                    columns: cols
                });

                _loadData($('#animal-ids').val(), ids, data);
            },
            error: function () {
                Dialog.error('系统异常，请联系系统管理员', '错误');
            }
        });
    });

    $('#primer-no').searchbox({
        prompt: '输入编号查询',
        searcher: function () {
            $('#primerIds-table').combogrid('grid').datagrid("load", {
                "no": $("#primer-no").searchbox('getValue')
            });
        }
    });
});

function _loadData(animalIds, primerIds, primerIdsForMatch) {
    $.ajax({
        url: getContentPath() + '/ag/cp/data.do',
        dataType: 'json',
        type: 'post',
        data: {
            'animalIds': animalIds,
            'primerIds': primerIds
        },
        success: function (data) {
//            [
//                {"id": 3, "microchipCode": "RP03", "tatooCode": "5", "name": "呼名三", "typeName": null, "genotypeInfos": {"Aifu-05": {"codeA": 338, "codeB": 223, "primerNo": null}, "Aifu-06": {"codeA": 128, "codeB": 252, "primerNo": null}}},
//                {"id": 4, "microchipCode": "RP04", "tatooCode": "4", "name": "04", "typeName": null, "genotypeInfos": {"Aifu-05": {"codeA": null, "codeB": null, "primerNo": null}, "Aifu-06": {"codeA": 339, "codeB": 334, "primerNo": null}}},
//                {"id": 5, "microchipCode": "rp05", "tatooCode": "5", "name": "05", "typeName": null, "genotypeInfos": {"Aifu-05": {"codeA": null, "codeB": null, "primerNo": null}, "Aifu-06": {"codeA": null, "codeB": null, "primerNo": null}}}
//            ]
            var rows = [];
            for (var i = 0; i < data.length; i++) {
                var obj = data[i];
                var row = {
                    'tatooCode': obj.tatooCode,
                    'microchipCode': obj.microchipCode
                };
                var info = obj.genotypeInfos;
                for (var k = 0; k < primerIdsForMatch.length; k++) {
                    var pid = primerIdsForMatch[k];
                    var no = pid.no;
                    row['codeA' + k] = info[no].codeA || '-';
                    row['codeB' + k] = info[no].codeB || '-';
                }
                rows.push(row);
            }
            $('#genotype-animal-compare-table').datagrid('loadData', rows);
        }, error: function () {
            Dialog.error('系统异常，请联系系统管理员', '错误');
        }
    })
}