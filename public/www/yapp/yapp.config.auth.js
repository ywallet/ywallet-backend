(function() {
    'use strict';

    angular
        .module('yapp')
        .config(configureAuth);

    configureAuth.$inject = ["$authProvider"];

    function configureAuth($authProvider) {
        var apiUrl = "https://ywallet.herokuapp.com";

        $authProvider.configure([{
            default: {
                apiUrl: apiUrl,
                emailSignInPath: "/auth/sign_in.json",
                /*
                tokenValidationPath:     '/auth/validate_token',
                signOutUrl:              '/auth/sign_out',
                emailRegistrationPath:   '/auth',
                accountUpdatePath:       '/auth',
                accountDeletePath:       '/auth',
                confirmationSuccessUrl:  window.location.href,
                passwordResetPath:       '/auth/password',
                passwordUpdatePath:      '/auth/password',
                passwordResetSuccessUrl: window.location.href,
                emailSignInPath:         '/auth/sign_in',
                storage:                 'cookies',
                proxyIf:                 function() { return false; },
                proxyUrl:                '/proxy',
                authProviderPaths: {
                    github:   '/auth/github',
                    facebook: '/auth/facebook',
                    google:   '/auth/google'
                },
                tokenFormat: {
                    "access-token": "{{ token }}",
                    "token-type":   "Bearer",
                    "client":       "{{ clientId }}",
                    "expiry":       "{{ expiry }}",
                    "uid":          "{{ uid }}"
                },
                parseExpiry: function(headers) {
                    // convert from UTC ruby (seconds) to UTC js (milliseconds)
                    return (parseInt(headers['expiry']) * 1000) || null;
                },
                handleLoginResponse: function(response) {
                    return response.data;
                },
                handleAccountResponse: function(response) {
                    return response.data;
                },
                handleTokenValidationResponse: function(response) {
                    return response.data;
                }
                */
            }
        }, {
            manager: {
                apiUrl: apiUrl,
                emailRegistrationPath: "/managers.json",
            }
        }, {
            child: {
                apiUrl: apiUrl,
                emailRegistrationPath: "/children.json",
            }
        }]);
    }
})();
