<%@ include file="/WEB-INF/template/include.jsp" %>

<%@ include file="/WEB-INF/template/header.jsp" %>
<%@ include file="localHeader.jsp" %>

<script type="text/javascript">

	function confirmPurge() {
		if (confirm("<spring:message code='appointment.AppointmentType.purgeConfirmMessage' />")) {
			return true;
		} else {
			return false;
		}
	}
	
</script>

<script type="text/javascript">
   function forceMaxLength(object, maxLength) {
      if( object.value.length >= maxLength) {
         object.value = object.value.substring(0, maxLength); 
      }
   }
</script>
<h2><spring:message code="appointment.AppointmentType.title"/></h2>

<spring:hasBindErrors name="appointmentType">
	<spring:message code="fix.error"/>
	<br />
</spring:hasBindErrors>
<form method="post">
<fieldset>
<table>
	<tr>
		<td><spring:message code="general.name"/></td>
		<td>
			<spring:bind path="appointmentType.name">
				<input type="text" name="name" value="${status.value}" size="35" />
				<c:if test="${status.errorMessage != ''}"><span class="error">${status.errorMessage}</span></c:if>
			</spring:bind>
		</td>
	</tr>
	<tr>
		<td valign="top"><spring:message code="general.description"/></td>
		<td valign="top">
			<spring:bind path="appointmentType.description">
				<textarea name="description" rows="3" cols="40" onkeypress="return forceMaxLength(this, 1024);" >${status.value}</textarea>
				<c:if test="${status.errorMessage != ''}"><span class="error">${status.errorMessage}</span></c:if>
			</spring:bind>
		</td>
	</tr>
	<tr>
		<td valign="top"><spring:message code="appointment.AppointmentType.enterDuration"/></td>
		<td valign="top">
			<spring:bind path="appointmentType.duration">
				<input type="text" name="duration" value="${status.value}" size="35" />
				<c:if test="${status.errorMessage != ''}"><span class="error">${status.errorMessage}</span></c:if>
			</spring:bind>
		</td>
	</tr>
	<c:if test="${!(appointmentType.creator == null)}">
		<tr>
			<td><spring:message code="general.createdBy" /></td>
			<td><openmrs:format user="${ appointmentType.creator }"/></td>
		</tr>
	</c:if>
</table>
<br />

<input type="submit" value="<spring:message code="appointment.AppointmentType.save"/>" name="save">

</fieldset>
</form>

<br/>

<c:if test="${not appointmentType.retired && not empty appointmentType.appointmentTypeId}">
	<form method="post">
		<fieldset>
			<h4><spring:message code="appointment.AppointmentType.retireAppointmentType"/></h4>

			<b><spring:message code="general.reason"/></b>
			<input type="text" value="" size="40" name="retireReason" />
			<spring:hasBindErrors name="appointmentType">
				<c:forEach items="${errors.allErrors}" var="error">
					<c:if test="${error.code == 'retireReason'}"><span class="error"><spring:message code="${error.defaultMessage}" text="${error.defaultMessage}"/></span></c:if>
				</c:forEach>
			</spring:hasBindErrors>
			<br/>
			<input type="submit" value='<spring:message code="appointment.AppointmentType.retireAppointmentType"/>' name="retire"/>
		</fieldset>
	</form>
</c:if>

<c:if test="${appointmentType.retired && not empty appointmentType.appointmentTypeId}">
	<form method="post">
		<fieldset>
			<h4><spring:message code="appointment.AppointmentType.unretireAppointmentType"/></h4>
			<input type="submit" value='<spring:message code="appointment.AppointmentType.unretireAppointmentType"/>' name="unretire"/>
		</fieldset>
	</form>
</c:if>

<br/>

<c:if test="${not empty appointmentType.appointmentTypeId}">
	<form id="purge" method="post" onsubmit="return confirmPurge()">
		<fieldset>
			<h4><spring:message code="appointment.AppointmentType.purgeAppointmentType"/></h4>
			<input type="submit" value='<spring:message code="appointment.AppointmentType.purgeAppointmentType"/>' name="purge" />
		</fieldset>
	</form>
</c:if>

<%@ include file="/WEB-INF/template/footer.jsp" %>