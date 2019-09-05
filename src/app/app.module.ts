import { BrowserModule } from '@angular/platform-browser';
import { NgModule, APP_INITIALIZER } from '@angular/core';
import { FormsModule }   from '@angular/forms';
import { HttpModule } from '@angular/http';
import { HttpClientModule } from '@angular/common/http';

import { AppRoutingModule } from './app-routing.module';

import { AppComponent } from './app.component';
import { ClassDropdownComponent } from './classDropdown/class-dropdown.component';
import { ClassWeekHeaderComponent } from './classWeekHeader/class-week-header.component';
import { ClassesComponent }   from './classes/classes.component';
import { OrderComponent }      from './order/order.component';
import { ReportComponent }  from './report/report.component';
import { RosterComponent } from './roster/roster.component';
import { StudentCheckInComponent } from './roster/studentCheckIn/student-check-in.component';
import { ClassEmailComponent } from './classEmail/class-email.component';
import { StudentEmailComponent } from './studentEmail/student-email.component';
import { StudentProfileComponent } from './studentProfile/student-profile.component';
import { StudentSearchComponent } from './studentSearch/student-search.component';
import { StudentSearchHeaderComponent } from './studentSearch/student-search-header/student-search-header.component';
import { StudentSearchResultsComponent } from './studentSearch/student-search-results/student-search-results.component';

import { BsDropdownModule } from 'ngx-bootstrap/dropdown';
import { ModalModule } from 'ngx-bootstrap/modal';
import { TabsModule } from 'ngx-bootstrap/tabs';

import { ClassService } from './services/class/class.service'
import { ClassAPIService } from './services/class/class-api.service'
import { StudentService } from './services/student/student.service'
import { StudentAPIService } from './services/student/student-api.service'
import { UtilitiesService } from './services/utilities.service'
import { ClassReportService } from './services/classReport/classReport.service'
import { ClassReportAPIService } from './services/classReport/classReport-api.service'

import { ConfigService } from './config/config.service'


export declare var Session_UserID: any;

@NgModule({
  declarations: [
      AppComponent,
      ClassDropdownComponent,
      ClassWeekHeaderComponent,
      ClassesComponent,
      OrderComponent,
      ReportComponent,
      RosterComponent,
      StudentCheckInComponent,
      ClassEmailComponent,
      StudentEmailComponent,
      StudentProfileComponent,
      StudentSearchComponent,
      StudentSearchHeaderComponent,
      StudentSearchResultsComponent
  ],
  imports: [
      BrowserModule,
      FormsModule,
      HttpModule,
      HttpClientModule,
      AppRoutingModule,
      BsDropdownModule.forRoot(),
      ModalModule.forRoot(),
      TabsModule.forRoot()
  ],
  providers: [ClassService, ClassAPIService, StudentService, StudentAPIService,
      ConfigService, UtilitiesService, ClassReportService, ClassReportAPIService
      ,
      {
          provide: APP_INITIALIZER,
          useFactory: initConfig,
          deps: [ConfigService],
          multi: true
      },
      {
          provide: 'Session_UserID', useValue: Session_UserID
      }
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }


export function initConfig(config: ConfigService) {
    return () => config.load();
}
