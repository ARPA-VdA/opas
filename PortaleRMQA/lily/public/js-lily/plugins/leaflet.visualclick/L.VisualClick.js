L.Map.VisualClick = L.Handler.extend({
    _makeVisualIcon: function(){
        var touchMode = this._map.options.visualClickMode === 'touch' ? true : false;
        return L.divIcon({
            className: "leaflet-visualclick-icon" + (touchMode ? '-touch' : ''),
            iconSize: [0, 0],
            clickable: false
        });
    },
    _visualIcon: null,
    _onClick: function(e) {
        var map = this._map;
        var latlng = e.latlng;
        var marker = L.marker(latlng, {
            pane: this._map.options.visualClickPane,
            icon: this._visualIcon,
            interactive: false
        }).addTo(map);
        window.setTimeout(function(){
            if(map){
                marker.remove();
            }
        }.bind(this), map.options.visualClick.removeTimeout || 450);
        return true;
    },
    addHooks: function () {
        if(this._visualIcon === null){
            this._visualIcon = this._makeVisualIcon();
        }
        if (this._map.options.visualClickPane === 'ie10-visual-click-pane') {
            this._map.createPane('ie10-visual-click-pane');
        }
        this._map.on(this._map.options.visualClickEvents, this._onClick, this);
    },
    removeHooks: function () {
        this._map.off(this._map.options.visualClickEvents, this._onClick, this);
    },
});
L.Map.mergeOptions({
    visualClick: L.Browser.any3d ? true : false,
    visualClickMode: L.Browser.touch && L.Browser.mobile ? 'touch' : 'desktop',
    visualClickEvents: 'click contextmenu',
    visualClickPane: (L.Browser.ie && document.documentMode === 10) ?
        'ie10-visual-click-pane' :
        'shadowPane'
});
L.Map.addInitHook('addHandler', 'visualClick', L.Map.VisualClick);
