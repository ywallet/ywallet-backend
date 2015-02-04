(function() {
    'use strict';

    angular
        .module('yapp.settings')
        .config(defineRoutes);

    defineRoutes.$inject = ["$stateProvider", "$urlRouterProvider"];
            
    function defineRoutes($stateProvider, $urlRouterProvider) {
        $stateProvider.state("yapp.settings", {
            url: "/settings",
            views: {
                menuContent: {
                    templateUrl: "yapp/settings/settings.html",
                    controller: "Settings"
                }
            }
        }).state("yapp.accountSettings", {
            url: "/acc-settings",
            abstract: true,
            views: {
                menuContent: {
                    templateUrl: "yapp/settings/account/settings.html"
                }
            }
        }).state("yapp.accountSettings.index", {
            url: "",
            views: {
                accountSettings: {
                    templateUrl: "yapp/settings/account/settings-index.html"
                }
            }
        }).state("yapp.accountSettings.personal", {
            url: "/personal-data",
            views: {
                accountSettings: {
                    templateUrl: "yapp/settings/account/personal-data.html",
                    controller: "PersonalData"
                }
            }
        }).state("yapp.accountSettings.password", {
            url: "/change-password",
            views: {
                accountSettings: {
                    templateUrl: "yapp/settings/account/change-password.html",
                    controller: "ChangePassword"
                }
            }
        }).state("yapp.childrenSettings", {
            url: "/child-settings",
            abstract: true,
            views: {
                menuContent: {
                    templateUrl: "yapp/settings/children/settings.html"
                }
            }
        }).state("yapp.childrenSettings.index", {
            url: "",
            views: {
                childrenSettings: {
                    templateUrl: "yapp/settings/children/settings-index.html",
                    controller: "ManageChildren"
                }
            }
        }).state("yapp.childrenSettings.newChild", {
            url: "/new-child",
            views: {
                childrenSettings: {
                    templateUrl: "yapp/settings/children/register.html",
                    controller: "RegisterChild"
                }
            }
        });
    }

})();
