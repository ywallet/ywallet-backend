(function(){
	'use strict';

	angular
		.module('yapp.services')
		.factory('DSHistory', DSHistory);

	DSHistory.$inject = ['$http', '$q', '$ionicLoading', 'DSCacheFactory'];
	function DSHistory($http, $q, $ionicLoading, DSCacheFactory)
	{
		var cacheKey = 'History';
		var hostname = (!window.cordova) ? 'api/' : '/android_asset/www/api/';

		var service = {
			getCacheKey : getCacheKey,
			getHistory: getHistory
		}

		return service;

		function getCacheKey() {
			return cacheKey;
		}

		function getHistory(loadCache) {

			var deferred = $q.defer(),
				historyCache = DSCacheFactory.get('localCache'),
				history = historyCache.get(cacheKey);

			if( loadCache === undefined )
				var loadCache = false;

			if( history )
				deferred.resolve(history);
			else
			{
				if( !loadCache )
					$ionicLoading.show({ template: 'Loading...'});

				$http.get(hostname + 'history.json')
					.success(function(data, status){
						historyCache.put(cacheKey, data);
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
	}

})()