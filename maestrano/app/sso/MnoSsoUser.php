<?php

/**
 * Configure App specific behavior for 
 * Maestrano SSO
 */
class MnoSsoUser extends MnoSsoBaseUser
{
  /**
   * Database connection
   * @var PDO
   */
  public $connection = null;
  
  
  /**
   * Extend constructor to inialize app specific objects
   *
   * @param OneLogin_Saml_Response $saml_response
   *   A SamlResponse object from Maestrano containing details
   *   about the user being authenticated
   */
  public function __construct(OneLogin_Saml_Response $saml_response, &$session = array(), $opts = array())
  {
    // Call Parent
    parent::__construct($saml_response,$session);
    
    // Assign new attributes
    $this->connection = $opts['db_connection'];
  }
  
  
  /**
   * Sign the user in the application. 
   * Parent method deals with putting the mno_uid, 
   * mno_session and mno_session_recheck in session.
   *
   * @return boolean whether the user was successfully set in session or not
   */
  protected function setInSession()
  {
    if ($this->local_id) {
        // Set session
        $this->session['user_id'] = $this->local_id;
        
        return true;
    } else {
        return false;
    }
  }
  
  
  /**
   * Used by createLocalUserOrDenyAccess to create a local user 
   * based on the sso user.
   * If the method returns null then access is denied
   *
   * @return the ID of the user created, null otherwise
   */
  protected function createLocalUser()
  {
    $lid = null;
    
    if ($this->accessScope() == 'private') {
      // Build user
      $user = $this->buildLocalUser();
      
      // Save user and retrieve id if successful
      if ($user->db_save()) {
        $lid = $user->user_id;
      }
      
    }
    
    return $lid;
  }
  
  /**
   * Build a user for creation.
   *
   * @return a SoPlanning user object
   */
  protected function buildLocalUser()
  {
    $user = new User();
    
  	$user->user_id = $this->uid;
  	$user->nom = "$this->name $this->surname";
  	$user->email = $this->email;
  	$user->user_groupe_id = null;
  	$user->login = $this->uid;
  	$user->password = sha1("¤" . $this->generatePassword() . "¤");
    $user->visible_planning = 'oui';
  	$user->notifications = 'non';
  	$user->couleur = 'FFFFFF';
  	$user->setDroits($this->getUserPrivileges());
    
    return $user;
  }
  
  /**
   * Return the privileges to grant to the local user
   *
   * @return array of privileges
   */
  protected function getUserPrivileges()
  {
    $def_admin_rights = ["users_manage_all", "projects_manage_all", "projectgroups_manage_all", "planning_modify_all", "planning_view_all_projects", "parameters_all"];
    $def_user_rights = ["planning_readonly","planning_view_all_projects"];
    
    $role_rights = $def_user_rights; // User
    
    if ($this->app_owner) {
      $role_rights = $def_admin_rights; // Admin
    } else {
      foreach ($this->organizations as $organization) {
        if ($organization['role'] == 'Admin' || $organization['role'] == 'Super Admin') {
          $role_rights = $def_admin_rights;
        } else {
          $role_rights = $def_user_rights;
        }
      }
    }
    
    return $role_rights;
  }
  
  /**
   * Get the ID of a local user via Maestrano UID lookup
   *
   * @return a user ID if found, null otherwise
   */
  protected function getLocalIdByUid()
  {
    $arg = addslashes($this->uid);
    $result = db_query("SELECT user_id FROM planning_user WHERE mno_uid = '{$arg}' LIMIT 1");
    $result = db_fetch_assoc($result);
    
    if ($result && $result['user_id']) {
      return $result['user_id'];
    }
    
    return null;
  }
  
  /**
   * Get the ID of a local user via email lookup
   *
   * @return a user ID if found, null otherwise
   */
  protected function getLocalIdByEmail()
  {
    $arg = addslashes($this->email);
    $result = db_query("SELECT user_id FROM planning_user WHERE email = '{$arg}' LIMIT 1");
    $result = db_fetch_assoc($result);
    
    if ($result && $result['user_id']) {
      return $result['user_id'];
    }
    
    return null;
  }
  
  /**
   * Set all 'soft' details on the user (like name, surname, email)
   * Implementing this method is optional.
   *
   * @return boolean whether the user was synced or not
   */
   protected function syncLocalDetails()
   {
     if($this->local_id) {
       $upd = db_query("UPDATE planning_user 
         SET nom = '" . addslashes($this->name . ' ' . $this->surname) ."',
         login = '" . addslashes($this->uid) ."', 
         email = '" . addslashes($this->email) ."'
         WHERE user_id = '" . addslashes($this->local_id) . "'");
       
       return $upd;
     }
     
     return false;
   }
  
  /**
   * Set the Maestrano UID on a local user via id lookup
   *
   * @return a user ID if found, null otherwise
   */
  protected function setLocalUid()
  {
    if($this->local_id) {
      $upd = db_query("UPDATE planning_user 
        SET mno_uid = '" . addslashes($this->uid) . "'
        WHERE user_id = '" . addslashes($this->local_id) . "'");
      
      return $upd;
    }
    
    return false;
  }
}