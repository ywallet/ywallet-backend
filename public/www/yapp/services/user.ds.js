(function(){
	"use strict";

	angular
		.module("yapp.services")
		.factory("DSUser", DSUser);

	DSUser.$inject = ["$rootScope", "$localStorage", "$http"];

	function DSUser($rootScope, $localStorage, $http) {
		var yUser = null,
            cacheKey = "yUser-cache";

		var service = {
            auth: null,
            getUser: getUser,
			putUser: putUser,
			rmUser: rmUser,
			loadUser: loadUser,
            updateUser: updateUser
		}

		return service;


        ////////////////////


		function getUser() {
			return yUser || loadUser();
		}


		function loadUser() {
			var user = $localStorage.getObject(cacheKey);
            if (yUser == null) {
                yUser = user;
                $rootScope.yUser = user;
            }
            return user;
		}


		function putUser(user) {
			$localStorage.setObject(cacheKey, user);
			$rootScope.yUser = user;
            yUser = user;
		}


		function rmUser() {
			$localStorage.setObject(cacheKey, null);
            $rootScope.yUser = null;
            yUser = null;
		}


        function updateUser(onSuccess, onError) {
            var role = yUser.role,
                url = role == "parent" ? "/managers" : "/children";
            $http.get("http://ywallet.co" + url)
                .success(function (data) {
                    data.role = role;
                    putUser(data);
                    onSuccess.apply(this, arguments);
                })
                .error(onError);
        }
	}

})()