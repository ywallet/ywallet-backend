(function() {
    'use strict';

    angular
        .module('yapp.authentication')
        .config(defineRoutes);

    defineRoutes.$inject = ["$stateProvider"];

    function defineRoutes($stateProvider) {
        $stateProvider.state("authentication", {
            url: "/authentication",
            abstract: true,
            templateUrl: "yapp/authentication/authentication.html"
        }).state("authentication.index", {
            url: "",
            views: {
                authContent: {
                    templateUrl: "yapp/authentication/authentication-index.html"
                }
            }
        }).state("authentication.signin", {
            url: "/signin",
            views: {
                authContent: {
                    templateUrl: "yapp/authentication/signin.html",
                    controller: "SignIn"
                }
            }
        }).state("authentication.register", {
            url: "/register",
            views: {
                authContent: {
                    templateUrl: "yapp/authentication/register.html",
                    controller: "Register"
                }
            }
        }).state("authentication.recovery", {
            url: "/recovery",
            views: {
                authContent: {
                    templateUrl: "yapp/authentication/forgot-password.html",
                    controller: "ForgotPassword"
                }
            }
        }).state("authentication.terms", {
            url: "/terms",
            views: {
                authContent: {
                    templateUrl: "yapp/authentication/terms.html"
                }
            }
        }).state("yapp.signout", {
            url: "/signout",
            views: {
                menuContent: {
                    templateUrl: "yapp/authentication/signout.html",
                    controller: "SignOut"
                }
            }
        })/*.state("auth", {
            url: "/auth",
            templateUrl: "yapp/authentication/authentication.html",
            controller: "Authenticator"
        })*/;
    }

})();
