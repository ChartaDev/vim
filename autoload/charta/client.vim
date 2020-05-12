let s:charta_hostname="https://www.charta.dev"
let s:charta_api_url=s:charta_hostname . "/api/v1"

if !exists('g:charta_api_token')
  let g:charta_api_token=""
endif

function! s:make_headers()
  return {
\    'Content-Type': 'application/json',
\    'Accept': 'application/json',
\    'x-api-key': g:charta_api_token
\  }
endfunction

function! s:put(url, data)
  let body = charta#json#encode(a:data)
  let response = charta#http#post(a:url, body, s:make_headers(), "PUT")
  return extend(response, {'content': charta#json#parse(response['content'])})
endfunction

function! s:get(url)
  let response = charta#http#get(a:url, s:make_headers())
  return extend(response, {'content': charta#json#parse(response['content'])})
endfunction

function! charta#client#add_node(tour_id, data)
  let url = s:charta_api_url . "/tours/" . a:tour_id . "/add_node"
  return s:put(url, a:data)
endfunction