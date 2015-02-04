(function() {
    'use strict';

    angular
        .module('yapp.rules')
        .config(defineRoutes);

    defineRoutes.$inject = ["$stateProvider", "$urlRouterProvider"];
            
    function defineRoutes($stateProvider, $urlRouterProvider) {
        $stateProvider.state("yapp.rules", {
            url: "/rules",
            views: {
                menuContent: {
                    templateUrl: "yapp/rules/rules.html",
                    controller: "Rules"
                }
            }
        });
    }

})();
