/**
 * 动物谱系管理
 *
 * @author Dendy
 * @since 2014-2-20 22:17:50
 */

$(function () {
    loadStudbookData(getContentPath() + "/as/loadDown.do", "studbook-image-down");
    loadStudbookData(getContentPath() + "/as/loadUp.do", "studbook-image-up");
});

function loadStudbookData(url, containerId) {
    $.ajax({
        url: url,
        type: "post",
        dataType: "json",
        data: {
            "animalId": $('#animal-studbook-animalId').val()
        },
        beforeSend: function (jqXHR, settings) {
            Dialog.fullprogress.open('谱系数据加载中，请稍候...', "操作");
        },
        complete: function (jqXHR, textStatus) {
            Dialog.fullprogress.close();
        },
        success: function (data, textStatus, jqXHR) {
            if (data.type == "error") {
                Dialog.error(data.msg, "错误");
            } else {
                _showStudBookData(data, containerId);
            }
        },
        error: function (jqXHR, textStatus, errorThrown) {
            Dialog.error("谱系数据加载失败，请稍后重试！", "错误");
        }
    });
}

function _showStudBookData(data, containerId) {
    // 根节点
    var root = new OrgNode();
    root.customParam.microchipCode = data.microchipCode;
    root.customParam.studbookCode = data.studbookCode;
    root.customParam.sex = data.sex;
    root.customParam.name = data.name;
    _parseNodes(data.children, root);
    var OrgShows = new OrgShow(root);
    OrgShows.containerId = containerId;
    OrgShows.Top = 50;
    OrgShows.Left = 50;
    OrgShows.IntervalWidth = 1;
    OrgShows.IntervalHeight = 20;
    //OrgShows.ShowType=2;
    //OrgShows.BoxHeight=100;
    OrgShows.BoxTemplet = "<div id=\"{Id}\" class=\"OrgBox\" onclick=\"\"><span title=\"芯片号\">{microchipCode}</span>" +
        "<div title=\"谱系号\">{studbookCode}</div><div><span style='color: blue;' title=\"呼名\">{name}</span></div>" +
        "<div><span style='color: red;' title=\"性别\">{sex}</span></div></div>";
    OrgShows.Run();
}

function _parseNodes(nodes, pOrgNode) {
    for (var i = 0; i < nodes.length; i++) {
        var node = nodes[i];
        var children = node.children;
        var orgNode = new OrgNode();
        orgNode.customParam.microchipCode = node.microchipCode;
        orgNode.customParam.studbookCode = node.studbookCode;
        orgNode.customParam.sex = node.sex;
        orgNode.customParam.name = node.name;
        pOrgNode.Nodes.Add(orgNode);
        if (children != undefined && children.length > 0)
            _parseNodes(children, orgNode);
    }
}