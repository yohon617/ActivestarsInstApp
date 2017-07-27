import { BrowserModule } from '@angular/platform-browser';
import { NgModule, APP_INITIALIZER } from '@angular/core';
import { FormsModule }   from '@angular/forms';
import { HttpModule } from '@angular/http';

import { AppRoutingModule } from './app-routing.module';

import { AppComponent } from './app.component';
import { ClassDropdownComponent } from './classDropdown/class-dropdown.component';
import { ClassWeekHeaderComponent } from './classWeekHeader/class-week-header.component';
import { ClassesComponent }   from './classes/classes.component';
import { OrderComponent }      from './order/order.component';
import { ReportComponent }  from './report/report.component';
import { RosterComponent } from './roster/roster.component';

import { BsDropdownModule } from 'ngx-bootstrap/dropdown';

import { ClassService } from './services/class/class.service'
import { ClassAPIService } from './services/class/class-api.service'
import { StudentService } from './services/student/student.service'
import { StudentAPIService } from './services/student/student-api.service'

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
      RosterComponent
  ],
  imports: [
      BrowserModule,
      FormsModule,
      HttpModule,
      AppRoutingModule,
      BsDropdownModule.forRoot()
  ],
  providers: [ClassService, ClassAPIService, StudentService, StudentAPIService,
      ConfigService
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