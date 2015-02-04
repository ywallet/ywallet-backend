(function() {
    'use strict';

    angular
        .module('yapp.layout')
        .config(defineRoutes);

    defineRoutes.$inject = ["$stateProvider", "$urlRouterProvider"];
            
    function defineRoutes($stateProvider, $urlRouterProvider) {
        $stateProvider.state("yapp", {
            url: "/yapp",
            abstract: true,
            templateUrl: "yapp/layout/sidemenu.html",
            controller: "Sidemenu"
        });
    }

})();
