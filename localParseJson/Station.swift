//
//  Stations.swift
//  testWork
//
//  Created by Филипп on 27.05.16.
//  Copyright © 2016 Chuwachesku. All rights reserved.
//

import Foundation

class Station{
	
	var countryTitle: String = ""
	var cityTitle: String = ""
	
	var cityTitleReplica	: String = ""
	var regionTitle: String = ""
	var stationTitle: String = ""
}


//{
//	"citiesFrom" : [  ],
//	"citiesTo" : [  ]
//}


//{
//	// Страна
//	"countryTitle" : "Австрия",
//	// Координаты города
//	"point" : {
//		"longitude" : 16.36879539489746,
//		"latitude" : 48.20253753662109
//	},
//	// Район
//	"districtTitle" : "",
//	// идентификатор
//	"cityId" : 2352,
//	// Название города
//	"cityTitle" : "Вена",
//	// Название региона
//	"regionTitle" : "",
//	// Перечень станций города
//	"stations" : […]
//}

//{
//	// именование страны – денормализация данных, дубль из города
//	"countryTitle" : "Австрия",
//	// Координаты станции (в общем случае отличаются от координат города)
//	"point" : {
//		"longitude" : 16.36879539489746,
//		"latitude" : 48.20253753662109
//	},
//	"districtTitle" : "",
//	// идентификатор города (обратная ссылка на город)
//	"cityId" : 2352,
//	// наименование города (обратная ссылка на город)
//	"cityTitle" : "город Вена",
//	// именование региона
//	"regionTitle" : "",
//	// идентификатор станции
//	"stationId" : 10154,
//	// полное именование станции
//	"stationTitle" : "International Busterminal, Edbergstarsse 200 A"
//},
