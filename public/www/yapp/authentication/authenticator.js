(function() {
    "use strict";

    angular
        .module("yapp.authentication")
        .factory("Authenticator", Authenticator);

    Authenticator.$inject = ["$window", "$cordovaOauth"];

    function Authenticator($window, $cordovaOauth) {
        return {
            authenticate: authenticate
        };
        
        ////////////////////

        function authenticate(service, onSuccess, onError) {
            var clientId = "7c49c1d40b21548106163d2fc4151671f6227cc27033ddf0c5fcb48f74e44019";
            if (service != "coinbase") { return false; }
            if (window.cordova) {
                $cordovaOauth.coinbase(clientId).then(onSuccess, onError);
            } else {
                coinbaseWebOauth(clientId);
            }
        }



        function coinbaseWebOauth(clientId) {
            var /*popup,
                width = 850,
                height = 600,
                left = (screen.width - width) / 2,
                top = (screen.height - height) / 4,
                deferred = $q.defer(),*/
                url = "https://coinbase.com/oauth/authorize?response_type=code",
                redirect_uri = "urn:ietf:wg:oauth:2.0:oob";
            // url += "&redirect_uri=" + encodeURIComponent(redirect_uri);
            url += "&redirect_uri=" + redirect_uri;
            url += "&client_id=" + clientId;
            url += "&scope=balance+addresses+send:bypass_2fa+transfer+transactions+user";
            url += "&meta[send_limit_amount]=100&meta[send_limit_currency]=USD&meta[send_limit_period]=day";

            $window.location.href = url;

            /*
            popup = $window.open(url, "_blank", "width=" + width + ",height=" + height +
                                     ",left=" + left + ",top=" + top); // +
                                     // ",location=no,clearsessioncache=yes,clearcache=yes");
            if (popup == null) {
                deferred.reject("Can't open popups.");
            } else {
                popup.addEventListener("unload", function (event) {
                    var requestToken;
                    console.log("unload", event);
                    console.log("URL", popup.location.href);
                    if ((event.newURL).indexOf("https://www.coinbase.com/oauth/authorize/") === 0) {
                        requestToken = (event.url).split("/")[5];
                        deferred.resolve(requestToken);
                    } else {   
                        deferred.reject("Problem authenticating:", event);
                    }
                    popup.close();
                }, false);
            }
            return deferred.promise;*/
        }
    }
})();