import { NgModule }             from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { ClassesComponent }   from './classes/classes.component';
import { OrderComponent }      from './order/order.component';
import { ReportComponent }  from './report/report.component';
import { RosterComponent } from './roster/roster.component';
import { StudentCheckInComponent } from './roster/studentCheckIn/student-check-in.component';
import { ClassEmailComponent } from './classEmail/class-email.component';
import { StudentEmailComponent } from './studentEmail/student-email.component';
import { StudentProfileComponent } from './studentProfile/student-profile.component';
import { StudentSearchComponent }  from './studentSearch/student-search.component';

const routes: Routes = [
  { path: '', redirectTo: '/classes', pathMatch: 'full' },
  { path: 'start.asp', redirectTo: '/classes', pathMatch: 'full' },
  { path: 'classes', component: ClassesComponent },
  { path: 'roster', component: RosterComponent },
  { path: 'studentCheckIn/:id', component: StudentCheckInComponent },
  { path: 'report', component: ReportComponent },
  { path: 'order', component: OrderComponent },
  { path: 'studentProfile/:id/:type', component: StudentProfileComponent },
  { path: 'studentSearch', redirectTo: '/studentSearch/new', pathMatch: 'full' },
  { path: 'studentSearch/:id', component: StudentSearchComponent },
];

@NgModule({
  imports: [ RouterModule.forRoot(routes) ],
  exports: [ RouterModule ]
})
export class AppRoutingModule {}
