//
//  UrlDefine.h
//  WeatherLifer
//
//  Created by ink on 15/6/16.
//  Copyright (c) 2015年 ink. All rights reserved.
//

#ifndef WeatherLifer_UrlDefine_h
#define WeatherLifer_UrlDefine_h
//#define BasicUrl @"http://dev.api.mlogcn.com:8000/"
#define BasicUrl @"http://api.weather.mlogcn.com:8000/"

#define CurrentWeather(lon,lat) [NSString stringWithFormat:@"api/weather/v2/ob/coor/%@/%@.json",lon,lat]
#define AllDayWeather(lon,lat) [NSString stringWithFormat:@"api/weather/v2/fc/24h/coor/%@/%@.json",lon,lat]
#define WeekWeather(lon,lat) [NSString stringWithFormat:@"api/weather/v2/summary/plot/coor/%@/%@.json",lon,lat]
#define WeekDetailWeather(lon,lat) [NSString stringWithFormat:@"api/weather/v2/hourly/plot/coor/%@/%@.json",lon,lat]
#define CurrentRain(lon,lat) [NSString stringWithFormat:@"api/weather/v2/nc/coor/%@/%@.json",lon,lat]
#define BatchGetWeather @"api/weather/v2/ob/batch/coor.json?"
#define Coor(lon,lat,num)  [NSString stringWithFormat:@"coor=%@,%@,%d",lon,lat,num]

#endif
