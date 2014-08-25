package com.hubspot.singularity.resources;

import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;

import org.apache.mesos.Protos.TaskID;
import org.apache.mesos.Protos.TaskState;
import org.apache.mesos.Protos.TaskStatus;

import com.google.inject.Inject;
import com.hubspot.singularity.SingularityAbort;
import com.hubspot.singularity.SingularityDriverManager;
import com.hubspot.singularity.SingularityLeaderController;
import com.hubspot.singularity.SingularityService;
import com.hubspot.singularity.WebExceptions;
import com.hubspot.singularity.config.SingularityConfiguration;

@Path(SingularityService.API_BASE_PATH + "/test")
public class TestResource {

  private final SingularityAbort abort;
  private final SingularityLeaderController managed;
  private final SingularityDriverManager driverManager;
  private final SingularityConfiguration configuration;

  @Inject
  public TestResource(SingularityConfiguration configuration, SingularityLeaderController managed, SingularityAbort abort, SingularityDriverManager driverManager) {
    this.configuration = configuration;
    this.managed = managed;
    this.abort = abort;
    this.driverManager = driverManager;
  }

  private void checkAllowed() {
    if (!configuration.allowTestResourceCalls()) {
      throw WebExceptions.webException(403, "Test resource calls are disabled (set allowTestResourceCalls to true in configuration)");
    }
  }

  @POST
  @Path("/scheduler/statusUpdate/{taskId}/{taskState}")
  public void statusUpdate(@PathParam("taskId") String taskId, @PathParam("taskState") String taskState) {
    checkAllowed();

    driverManager.getDriver().getScheduler().statusUpdate(null, TaskStatus.newBuilder()
        .setTaskId(TaskID.newBuilder().setValue(taskId))
        .setState(TaskState.valueOf(taskState))
        .build());
  }

  @POST
  @Path("/leader")
  public void setLeader() {
    checkAllowed();

    managed.isLeader();
  }

  @POST
  @Path("/notleader")
  public void setNotLeader() {
    checkAllowed();

    managed.notLeader();
  }

  @POST
  @Path("/stop")
  public void stop() throws Exception {
    checkAllowed();

    managed.stop();
  }

  @POST
  @Path("/abort")
  public void abort() {
    checkAllowed();

    abort.abort();
  }

  @POST
  @Path("/start")
  public void start() throws Exception {
    checkAllowed();

    managed.start();
  }

}
