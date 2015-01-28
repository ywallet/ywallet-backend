(function(){
	'use strict';

	angular
		.module('yapp.services')
		.factory('DSavings', DSavings);

	DSavings.$inject = ['$http', '$q', '$ionicLoading', 'DSCacheFactory'];
	function DSavings($http, $q, $ionicLoading, DSCacheFactory)
	{
		var cacheKey = 'Savings';
		var hostname = (!window.cordova) ? 'api/' : '/android_asset/www/api/';

		var service = {
			getCacheKey : getCacheKey,
			addSaving: addSaving,
			rmSaving: rmSaving,
			getSavings: getSavings
		}

		return service;

		function getCacheKey() {
			return cacheKey;
		}

		function getSavings(loadCache) {

			var deferred = $q.defer(),
				savingsCache = DSCacheFactory.get('localCache'),
				savings = savingsCache.get(cacheKey);

			if( loadCache === undefined )
				var loadCache = false;

			if( savings )
				deferred.resolve(savings);
			else
			{
				if( !loadCache )
					$ionicLoading.show({ template: 'Loading...'});

				$http.get(hostname + 'savings.json')
					.success(function(data, status){
						savingsCache.put(cacheKey, data);
						deferred.resolve(data);

						if( !loadCache )
							$ionicLoading.hide();
					})
					.error(function(data, status){
						deferred.reject();

						if( !loadCache )
							$ionicLoading.hide();
					});
			}

			return deferred.promise;
		}
		
		function addSaving(title, description, qty, deadline) {


		}

		function rmSaving(id) {

		}
	}

})()