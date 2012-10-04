/*
 * BigBlueButton - http://www.bigbluebutton.org
 * 
 * Copyright (c) 2008-2009 by respective authors (see below). All rights reserved.
 * 
 * BigBlueButton is free software; you can redistribute it and/or modify it under the 
 * terms of the GNU Lesser General Public License as published by the Free Software 
 * Foundation; either version 3 of the License, or (at your option) any later 
 * version. 
 * 
 * BigBlueButton is distributed in the hope that it will be useful, but WITHOUT ANY 
 * WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A 
 * PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public License along 
 * with BigBlueButton; if not, If not, see <http://www.gnu.org/licenses/>.
 *
 * $Id: $
 */

//  This closure is to enable logging in production. 
//	This closure is passed the location of the staging directory that
//	is zipped up to make the WAR file, and the command line arguments.
//	Here we copy over oug log4j.properties file while the web.xml is
//  overridden from what's in src/templates/war/web.xml.
// (ralam, jan 7, 2010)
grails.war.resources = {stagingDir, args ->
	//println '*** Copying our custom web.xml and log4j.properties as workaround for logging problem. ***'
	//println '*** Copying our custom web.xml as workaround for logging problem. ***'
	//copy(file: "grails-app/conf/custom-web.xml", tofile: "${stagingDir}/WEB-INF/web.xml")
	println '*** Copying our custom log4j.properties as workaround for logging problem. ***'
	copy(file: "grails-app/conf/log4j.properties", tofile: "${stagingDir}/WEB-INF/classes/log4j.properties")
}	



grails.servlet.version = "2.4" // Change depending on target container compliance (2.5 or 3.0)
grails.project.class.dir = "target/classes"
grails.project.test.class.dir = "target/test-classes"
grails.project.test.reports.dir = "target/test-reports"
grails.project.target.level = 1.5
grails.project.source.level = 1.5
//grails.project.war.file = "target/${appName}-${appVersion}.war"

grails.project.dependency.resolution = {
    // inherit Grails' default dependencies
    inherits("global") {
        // specify dependency exclusions here; for example, uncomment this to disable ehcache:
        // excludes 'ehcache'
    }
    log "error" // log level of Ivy resolver, either 'error', 'warn', 'info', 'debug' or 'verbose'
    checksums true // Whether to verify checksums on resolve

    repositories {
        inherits true // Whether to inherit repository definitions from plugins

        grailsPlugins()
        grailsHome()
        grailsCentral()

        mavenLocal()
        mavenCentral()

        // uncomment these (or add new ones) to enable remote dependency resolution from public Maven repositories
        //mavenRepo "http://snapshots.repository.codehaus.org"
        //mavenRepo "http://repository.codehaus.org"
        //mavenRepo "http://download.java.net/maven/2/"
        //mavenRepo "http://repository.jboss.com/maven2/"
    }

    dependencies {
        // specify dependencies here under either 'build', 'compile', 'runtime', 'test' or 'provided' scopes eg.
		compile 'redis.clients:jedis:2.0.0'
		compile 'commons-pool:commons-pool:1.5.6'
		compile 'commons-lang:commons-lang:2.5'
		compile 'com.google.code.gson:gson:1.7.1'
		compile 'junit:junit:4.8.2'
    }
}
	

