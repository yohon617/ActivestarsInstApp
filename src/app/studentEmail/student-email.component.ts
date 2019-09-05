import { Component, OnInit, EventEmitter, Input, Output } from '@angular/core';
import { ActivatedRoute, Params } from '@angular/router';
import { Location } from '@angular/common';
import { BsModalRef } from 'ngx-bootstrap/modal/modal-options.class';

import { Class } from './../models/class';
import { ClassService } from './../services/class/class.service';
import { StudentRoster } from '../models/studentRoster';


@Component({
  selector: 'student-email',
  templateUrl: './student-email.component.html',
  styleUrls: ['./student-email.component.css']
})
export class StudentEmailComponent implements OnInit {

  @Input() modalRef: BsModalRef;
  @Input() student: StudentRoster;
  instructorEmail: string;
  successMessage: string;
  failMessage: string;
  subject: string;
  body: string;

  constructor(
    private location: Location,
    private classService: ClassService,
    private route: ActivatedRoute
  ) { }

  ngOnInit(): void {
    this.classService.getInstructorEmail()
      .then(result => {
        this.instructorEmail = result;
      });
    this.successMessage = "";
    this.failMessage = "";
    this.subject = "";
    this.body = "";
  }

  sendEmail(element) {
    this.successMessage = "";
    this.failMessage = "";

    if (this.subject == "" || this.body == "") {
      this.failMessage = "Please fill in Subject AND Body.";
    }
    else {
      element.textContent = "Sending...";
      element.disabled = true;

      this.classService.sendStudentEmail(this.instructorEmail, this.student.PEmail, this.subject, this.body.replace(/\n/g, '<br>'))
        .then(result => {
          if (result) { this.successMessage = "Email Sent"; }
          else { this.failMessage = "Email Send Failed"; }
          element.textContent = "Send";
          element.disabled = false;
        });
    }
    //this.modalRef.hide();
  }

}
