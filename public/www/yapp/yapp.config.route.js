(function() {
    'use strict';

    angular
        .module('yapp')
        .config(defineRoutes);

    defineRoutes.$inject = ["$stateProvider", "$urlRouterProvider"];

    function defineRoutes($stateProvider, $urlRouterProvider) {
        $stateProvider.state("home", {
            url: "/",
            templateUrl: "yapp/preloader/preloader.html",
            controller: "Preloader"
        });

        $urlRouterProvider.otherwise("/");
    }
})();
